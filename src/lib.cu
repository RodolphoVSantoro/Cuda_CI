#include "lib.h"

__global__
void soma(int N, int *v1, int *v2){
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if(i<N)
    v2[i]+=v1[i];
}
