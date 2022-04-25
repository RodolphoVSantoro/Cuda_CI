#include <tuple>

#define CATCH_CONFIG_MAIN
#include "catch.hpp"
#include <stdio.h>
#include "../src/lib.h"

#define HANDLE_ERROR(status) { cudaEvalStatus((status),__FILE__,__LINE__); }

static inline void cudaEvalStatus(cudaError_t status, const char * filename, unsigned int line){
    if (status != cudaSuccess){
        printf("CUDA error in %s (line %i): %s\n",filename,line,cudaGetErrorString(status));
        cudaDeviceReset();
        exit(0);
    }
}

TEST_CASE("Ex1", "[example]")
{
    int *d_v1, *d_v2;    
    int *v1, *v2, *v3;
    v1 = (int*)malloc(sizeof(int)*2);
    v2 = (int*)malloc(sizeof(int)*2);
    v3 = (int*)malloc(sizeof(int)*2);
    v1[0]=v1[1]=1;
    v2[0]=v2[1]=2;
    cudaMalloc(&d_v1, 2*sizeof(int)); 
    cudaMalloc(&d_v2, 2*sizeof(int));
    cudaMemcpy(d_v1, v1, 2*sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_v2, v2, 2*sizeof(int), cudaMemcpyHostToDevice);
    HANDLE_ERROR(cudaPeekAtLastError());
    soma<<<2,1>>>(2,d_v1,d_v2);
    cudaMemcpy(v3, d_v2, 2*sizeof(int), cudaMemcpyDeviceToHost);
    for(int i=0;i<2;i++){
        printf("%d: %d==%d+%d\n", i, v3[i], v1[i], v2[i]);
        REQUIRE(v3[i]==v1[i]+v2[i]);
    }
    cudaFree(d_v1);
    cudaFree(d_v2);
    free(v1);
    free(v2);
    free(v3);
}
