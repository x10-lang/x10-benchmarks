/*
 *  This file is part of the X10 project (http://x10-lang.org).
 *
 *  This file is licensed to You under the Eclipse Public License (EPL);
 *  You may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *      http://www.opensource.org/licenses/eclipse-1.0.php
 *
 *  (C) Copyright IBM Corporation 2006-2014.
 */

import x10.compiler.Mutable;
import x10.compiler.Native;
import x10.compiler.NativeCPPCompilationUnit;
import x10.compiler.NativeCPPInclude;
import x10.compiler.NativeRep;
import x10.util.Option;
import x10.util.OptionsParser;
import x10.util.Team;


@NativeCPPInclude("Vec.h")
@NativeCPPCompilationUnit("Vec.cc")
@NativeRep("c++", "NativeVec<#T, ##size#-1#>", "NativeVec<#T, ##size#-1#>", null)
@Mutable struct Vec[T] (@Native("c++","#this.size()")size:Int) {

    private backing : Rail[T];
    private def this(s:Int) {T haszero} : Vec[T]{self.size==s} {
        property(s);
        backing = new Rail[T](size);
    }

    @Native("c++", "NativeVec<#U, #s>(#s)")
    public static def make[U](s:Int) {U haszero}: Vec[U]{self.size==s} = new Vec[U](s);

    @Native("c++", "#this.get(#i)")
    public operator this(i:Int) : T = backing(i);

    @Native("c++", "#this.set(#v,#i)")
    public operator this(i:Int) = (v:T) : T = backing(i) = v;

    @Native("c++", "(#this)->toString()")
    public def toString():String = backing.toString();

    @Native("c++", "(#this)->equals(#that)")
    public def equals(that:Any):Boolean {
        if (that instanceof Vec[T]) {
            return this.backing.equals((that as Vec[T]).backing);
        }
        return false;
    }

    @Native("c++", "(#this)->hashCode()")
    public def hashCode():Int = size;
}


final class KMeansVec {
    static def sub(str:String, start:Int, end:Int) = str.substring(start, Math.min(end, str.length()));

    static def printClusters(clusters:Rail[Float], dims:Int) {
        for (var d:Int=0n; d<dims; ++d) { 
            for (var k:Int=0n; k<clusters.size/dims; ++k) { 
                if (k>0n) Console.OUT.print(" ");
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

        val num_slice_points = num_global_points / Place.numPlaces();

        Place.places().broadcastFlat(()=>{
            val role = Runtime.hereInt();
            val random = new Random(role);
            val host_points = new Rail[Float](num_slice_points*dim, (Long)=>random.next());

            val host_clusters = new Rail[Float](num_clusters*dim);
            val host_cluster_counts = new Rail[Int](num_clusters);

            val team = Team.WORLD;

            if (role == 0n) {
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
                    val closest = Vec.make[Int](8n);
                    val closest_dist = Vec.make[Float](8n);
                    for (var w:Int=0n; w<8n; ++w) closest(w) = -1n;
                    for (var w:Int=0n; w<8n; ++w) closest_dist(w) = 1e37f;
                    for (var k:Int=0n; k<num_clusters; ++k) {
		        val dist = Vec.make[Float](8n);
                        for (var w:Int=0n; w<8n; ++w) dist(w) = 0.0f;
                        for (var d:Int=0n; d<dim; ++d) {
                            val tmp = Vec.make[Float](8n);
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

                if (role == 0n) {
                    Console.OUT.println("Iteration: " + iter);
                    if (verbose) printClusters(host_clusters, dim);
                }
            }

            val stop_time = System.nanoTime();

            if (role == 0n) Console.OUT.println("place: " + role + " computation time: "+compute_time/1E9 +
                    " communication time: " + comm_time/1E9);

            team.barrier();

            if (role == 0n) {
                Console.OUT.println("Total time: " + (stop_time-start_time)/1E9);
            }
        });
    }
}
