import x10.compiler.StackAllocate;
import x10.compiler.StackAllocateUninitialized;
import x10.util.Option;
import x10.util.OptionsParser;
import x10.util.Team;


final class KMeans {
    static def sub(str:String, start:Int, end:Int) = str.substring(start, Math.min(end, str.length()));

    static def printClusters(clusters:Rail[Float], dims:Int) {
        for (var d:Int=0n; d<dims; ++d) { 
            for (var k:Int=0n; k<clusters.size/dims; ++k) { 
                if (k>0) Console.OUT.print(" ");
                Console.OUT.print(sub(clusters(k*dims+d).toString(), 0n, 6n));
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
        val num_clusters = opts("-c", 8n);
        val num_global_points = opts("-n", 2000n);
        val iterations = opts("-i", 10n);
        val dim = opts("-d", 3n);
        val verbose = opts("-v");

        Console.OUT.println("places: " + Place.numPlaces() + " points: " + num_global_points + " clusters: " + num_clusters +
                " dimensions: " + dim + " iterations: " + iterations);

        val num_slice_points = num_global_points / (Place.numPlaces() as Int);

        Place.places().broadcastFlat(()=>{
            val role = here.id;
            val random = new Random(role as Int);
            val host_points = new Rail[Float](num_slice_points*dim, (Long)=>random.next());

            val host_clusters = new Rail[Float](num_clusters*dim);
            val host_cluster_counts = new Rail[Int](num_clusters);

            val team = Team.WORLD;

            if (role == 0) {
                for (var k:Int=0n; k<num_clusters; ++k) {
                    for (var d:Int=0n; d<dim; ++d) {
                        host_clusters(k*dim+d) = host_points(k+d*num_slice_points);
                    }
                }
            }

            val old_clusters = new Rail[Float](host_clusters.size);

            var compute_time:Long = 0;
            var comm_time:Long = 0;

            team.allreduce(host_clusters, 0L, host_clusters, 0L, host_clusters.size, Team.ADD);

            val start_time = System.nanoTime();

            for (var iter:Int=0n; iter<iterations; ++iter) {

                Rail.copy(host_clusters, old_clusters);
                host_clusters.clear();
                host_cluster_counts.clear();

                val compute_start = System.nanoTime();
                for (var p:Int=0n; p<num_slice_points; p+=8) {
                    @StackAllocate val closest = @StackAllocateUninitialized new Rail[Int](8L);
                    @StackAllocate val closest_dist = @StackAllocateUninitialized new Rail[Float](8L);
                    for (var w:Int=0n; w<8n; ++w) closest(w) = -1n;
                    for (var w:Int=0n; w<8n; ++w) closest_dist(w) = 1e37f;
                    for (var k:Int=0n; k<num_clusters; ++k) {
                        @StackAllocate val dist = @StackAllocateUninitialized new Rail[Float](8L);
                        for (var w:Int=0n; w<8n; ++w) dist(w) = 0.0f;
                        for (var d:Int=0n; d<dim; ++d) {
                            @StackAllocate val tmp = @StackAllocateUninitialized new Rail[Float](8L);
                            for (var w:Int=0n; w<8n; ++w) {
                                tmp(w) = host_points(p+w+d*num_slice_points) - old_clusters(k*dim+d);
                            }
                            for (var w:Int=0n; w<8n; ++w) {
                                dist(w) = dist(w) + tmp(w) * tmp(w);
                            }
                        }
                        for (var w:Int=0n; w<8n; ++w) {
                            if (dist(w) < closest_dist(w)) {
                                closest_dist(w) = dist(w);
                                closest(w) = k;
                            }
                        }
                    }
                    for (var d:Int=0n; d<dim; ++d) {
                        for (var w:Int=0n; w<8n; ++w) {
                            val index = closest(w)*dim+d;
                            host_clusters(index) += host_points(p+w+d*num_slice_points);
                        }
                    }
                    for (var w:Int=0n; w<8n; ++w) ++host_cluster_counts(closest(w));
                }
                compute_time += System.nanoTime() - compute_start;

                val comm_start = System.nanoTime();
                team.allreduce(host_clusters, 0L, host_clusters, 0L, host_clusters.size, Team.ADD);
                team.allreduce(host_cluster_counts, 0L, host_cluster_counts, 0L, host_cluster_counts.size, Team.ADD);
                comm_time += System.nanoTime() - comm_start;

                for (var k:Int=0n; k<num_clusters; ++k) {
                    for (var d:Int=0n; d<dim; ++d) host_clusters(k*dim+d) /= host_cluster_counts(k);
                }

                if (role == 0) {
                    Console.OUT.println("Iteration: " + iter);
                    if (verbose) printClusters(host_clusters, dim);
                }
            }

            val stop_time = System.nanoTime();

            if (role == 0) Console.OUT.println("place: " + role + " computation time: "+compute_time/1E9 +
                    " communication time: " + comm_time/1E9);

            team.barrier();

            if (role == 0) {
                Console.OUT.println("Total time: " + (stop_time-start_time)/1E9);
            }
        });
    }
}
