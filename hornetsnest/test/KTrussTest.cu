#include "Static/KTruss/KTruss.cuh"
#include <Device/Util/Timer.cuh>
#include <Graph/GraphStd.hpp>

using namespace timer;
using namespace hornets_nest;

int main(int argc, char **argv) {
    // cudaSetDevice(1);
    using namespace graph::structure_prop;
    using namespace graph::parsing_prop;

    graph::GraphStd<vid_t, eoff_t> graph(UNDIRECTED);
    graph.read(argv[1], SORT | PRINT_INFO);

    HornetInit hornet_init(graph.nV(), graph.nE(), graph.csr_out_offsets(),
                           graph.csr_out_edges(), true);

    HornetInit hcopy_init(graph.nV(), 0, graph.csr_out_offsets(),
                           graph.csr_out_edges(), true);

    HornetGraph hornet_graph(hornet_init);
    KTruss ktruss(hornet_graph);
    ktruss.run();
}
