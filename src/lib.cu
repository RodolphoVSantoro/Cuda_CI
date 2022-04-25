#include "lib.h"
#include <stdio.h>

__global__ void soma(int N, int *v1, int *v2){
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  printf("blockid=%d, blockdim=%d, threadid=%d\n", blockIdx.x, blockDim.x, threadIdx.x);
  printf("i=%d, v1=%d, v2=%d\n", i, v1[i], v2[i]);
  if(i<N)
    v2[i]+=v1[i];
}
