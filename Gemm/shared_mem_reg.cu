#include "../include/cuda.h"
#include "../include/cuda_runtime.h"
#include "../include/device_launch_parameters.h"
#include "../include/crt/device_functions.h"

const int KM = 2048;
const int KK = 2048;
const int KN = 2048;

const int KBm = 128;
const int KBk = 8;
const int KBn = 128;

const int KTm = 8;
const int KTn = 8;

/*
使用shared mem + reg
*/
__global__ void MatrixMultiplyUseSharedMemReg(float* input_m, float* input_n, float* output, int m, int k, int n)
{
    __shared__ float ms[KBm][KBk];
    __shared__ float ns[KBk][KBn];

    float r_c[KTm][KTn] = {0};

    // tid表示在对应thread在block中的全局id
    int tid = threadIdx.y * blockDim.x + threadIdx.x;

    

}