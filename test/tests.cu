#include <tuple>

#define CATCH_CONFIG_MAIN
#include "catch.hpp"

#include "../src/lib.h"

TEST_CASE("Ex1", "[example]")
{
    int *d_v1, *d_v2;
    int v1[2] = {1,1},
    v2[2] = {2,2}, v3[2];
    cudaMalloc(&d_v1, 2*sizeof(int)); 
    cudaMalloc(&d_v2, 2*sizeof(int));
    cudaMemcpy(d_v1, v1, 2*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_v2, v2, 2*sizeof(int), cudaMemcpyHostToDevice);
    soma<<<2,1>>>(2,d_v1,d_v2);
    cudaMemcpy(v3, d_v2, 2*sizeof(int), cudaMemcpyDeviceToHost);
    for(int i=0;i<2;i++){
        REQUIRE(v3[i]==v1[i]+v2[i]);
    }
    cudaFree(d_v1);
    cudaFree(d_v2);
}
