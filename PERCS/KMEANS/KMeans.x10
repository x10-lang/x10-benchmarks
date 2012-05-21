import x10.compiler.Native;
import x10.util.Option;
import x10.util.OptionsParser;
import x10.util.Team;
import x10.util.Vec;

final class Random {
    @Native("c++", "srandom(#seed)")
    static native def srandom(seed:Int):void;

    @Native("c++", "random()")
    native def rand():Long;

    def this(seed:Int) {
        srandom(seed);
    }

    def next() = (rand() as Float)/2147483648f;
}

final class KMeans {
    static def sub(str:String, start:Int, end:Int) = str.substring(start, Math.min(end, str.length()));

    static def printClusters(clusters:Rail[Float], dims:Int) {
        for (var d:Int=0; d<dims; ++d) { 
            for (var k:Int=0; k<clusters.size/dims; ++k) { 
                if (k>0) Console.OUT.print(" ");
                Console.OUT.print(sub(clusters(k*dims+d).toString(), 0, 6));
            }
            Console.OUT.println();
        }
    }

    public static def main(args:Rail[String]) {
        val opts = new OptionsParser(args, [
            Option("v", "verbose", "print out clusters")], [
            Option("i", "iterations", "quit after this many iterations"),
            Option("c", "clusters", "number of clusters to find"),
            Option("d", "dimensions", "number of dimensions"),
            Option("n", "num", "quantity of points")]);
        val num_clusters = opts("-c", 8);
        val num_global_points = opts("-n", 2000);
        val iterations = opts("-i", 10);
        val dim = opts("-d", 3);
        val verbose = opts("-v");

        Console.OUT.println("points: " + num_global_points + " clusters: " + num_clusters +
                " dimensions: " + dim + " iterations: " + iterations);

        val num_slice_points = num_global_points / Place.MAX_PLACES;

        finish for (var h:Int=0; h<Place.MAX_PLACES; ++h) at (Place(h)) async {
            val role = Runtime.hereInt();
            val random = new Random(role);
            val host_points = new Rail[Float](num_slice_points*dim, (Int)=>random.next());

            val host_clusters = new Rail[Float](num_clusters*dim);
            val host_cluster_counts = new Rail[Int](num_clusters);

            val team = Team.WORLD;

            if (role == 0) {
                for (var k:Int=0; k<num_clusters; ++k) {
                    for (var d:Int=0; d<dim; ++d) {
                        host_clusters(k*dim+d) = host_points(k+d*num_slice_points);
                    }
                }
            }

            val old_clusters = new Rail[Float](num_clusters*dim);

            var compute_time:Long = 0;
            var comm_time:Long = 0;

            team.allreduce(role, host_clusters, 0, host_clusters, 0, host_clusters.size, Team.ADD);

            val start_time = System.nanoTime();

            for (var iter:Int=0; iter<iterations; ++iter) {

                Array.copy(host_clusters, old_clusters);
                host_clusters.clear();
                host_cluster_counts.clear();

                val compute_start = System.nanoTime();
                for (var p:Int=0; p<num_slice_points; p+=8) {
                    val closest = Vec.make[Int](8);
                    val closest_dist = Vec.make[Float](8);
                    for (var w:Int=0; w<8; ++w) closest(w) = -1;
                    for (var w:Int=0; w<8; ++w) closest_dist(w) = 1e37f;
                    for (var k:Int=0; k<num_clusters; ++k) {
                        val dist = Vec.make[Float](8);
                        for (var w:Int=0; w<8; ++w) dist(w) = 0.0f;
                        for (var d:Int=0; d<dim; ++d) {
                            val tmp = Vec.make[Float](8);
                            for (var w:Int=0; w<8; ++w) {
                                tmp(w) = host_points(p+w+d*num_slice_points) - old_clusters(k*dim+d);
                            }
                            for (var w:Int=0; w<8; ++w) {
                                dist(w) = dist(w) + tmp(w) * tmp(w);
                            }
                        }
                        for (var w:Int=0; w<8; ++w) {
                            if (dist(w) < closest_dist(w)) {
                                closest_dist(w) = dist(w);
                                closest(w) = k;
                            }
                        }
                    }
                    for (var d:Int=0; d<dim; ++d) {
                        for (var w:Int=0; w<8; ++w) {
                            val index = closest(w)*dim+d;
                            host_clusters(index) += host_points(p+w+d*num_slice_points);
                        }
                    }
                    for (var w:Int=0; w<8; ++w) ++host_cluster_counts(closest(w));
                }
                compute_time += System.nanoTime() - compute_start;

                val comm_start = System.nanoTime();
                team.allreduce(role, host_clusters, 0, host_clusters, 0, host_clusters.size, Team.ADD);
                team.allreduce(role, host_cluster_counts, 0, host_cluster_counts, 0, host_cluster_counts.size, Team.ADD);
                comm_time += System.nanoTime() - comm_start;

                for (var k:Int=0; k<num_clusters; ++k) {
                    for (var d:Int=0; d<dim; ++d) host_clusters(k*dim+d) /= host_cluster_counts(k);
                }

                if (role == 0) {
                    Console.OUT.println("Iteration: " + iter);
                    if (verbose) printClusters(host_clusters, dim);
                }
            }

            val stop_time = System.nanoTime();

            if (role == 0) Console.OUT.println("Place: " + role + " computation time: "+compute_time/1E9 +
                    " communication time: " + comm_time/1E9);

            team.barrier(role);

            if (role == 0) {
                Console.OUT.println("Total time: " + (stop_time-start_time)/1E9);
            }
        }
    }
}
