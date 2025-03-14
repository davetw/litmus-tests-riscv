/* Topologies for threads in {2} */

/***************/
/* nthreads=2 */
/***************/

/*
 Topology: {{{0, 1, 2, 3}}}
*/

static const int _cpu_scan_2[] = {
// [[0,1]]
0, 1, 2, 3,
};

const int *cpu_scan_2 = &_cpu_scan_2[0];

static const char *_group_2[] = {
"[[0,1]]",
};

const char **group_2 = &_group_2[0];


