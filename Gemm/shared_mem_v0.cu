#include "../include/cuda.h"
#include "../include/cuda_runtime.h"
#include "../include/device_launch_parameters.h"
#include "../include/crt/device_functions.h"

const int KM = 2048;
const int KK = 2048;
const int KN = 2048;

const int KBm = 32;
const int KBk = 32;
const int KBn = 32;

/*
使用shared mem
*/
__global__ void MatrixMultiplyUseSharedMemV0(float* input_m, float* input_n, float* output, int m, int k, int n)
{
    __shared__ float ms[KBm][KBk];
    __shared__ float ns[KBk][KBn];
    int row_idx = blockIdx.y * blockDim.y + threadIdx.y;
    int col_idx = blockIdx.x * blockDim.x + threadIdx.x;
    float sum = 0.0;
    for (int k = 0; k < (KBk + KK - 1) / KBk; k++) {
        ms[threadIdx.y][threadIdx.x] = input_m[row_idx*KK+k*KBk+threadIdx.x];
        ns[threadIdx.y][threadIdx.x] = input_n[(k*KBk+threadIdx.y)*KN+col_idx];
        __syncthreads();

        for (int i = 0; i < KBk; i++) {
           sum += ms[threadIdx.y][i] * ns[i][threadIdx.x]; 
        }
        __syncthreads();
    }

    output[row_idx*KN+col_idx] = sum;
}