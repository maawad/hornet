#include "Static/KTruss/KTruss.cuh"

#include <StandardAPI.hpp>
#include <Device/Util/Timer.cuh>
#include <Graph/GraphStd.hpp>

using namespace std;
using namespace timer;
using namespace hornets_nest;


int main(int argc, char **argv) {

    using namespace graph::structure_prop;
    using namespace graph::parsing_prop;

    int device=0;

    cudaSetDevice(device);
    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, device);
 
    graph::GraphStd<vid_t, eoff_t> graph(UNDIRECTED);
    graph.read(argv[1], SORT | PRINT_INFO);


    HornetInit hornet_init(graph.nV(), graph.nE(),
                                 graph.csr_out_offsets(),
                                 graph.csr_out_edges());

    std::cout << "Initializing GPU graph" << std::endl;
    HornetGraph hornet_graph(hornet_init);
    std::cout << "Checking sortd adj" << std::endl;

    hornet_graph.check_sorted_adjs();
    // std::cout << "Is sorted " <<  << std::endl;

    KTruss ktruss(hornet_graph);

    ktruss.init();
    ktruss.reset();
    ktruss.run();
}
