#include <stdio.h>
#include "../include/cuda.h"
#include "../include/cuda_runtime.h"
#include "../include/device_launch_parameters.h"
#include "../include/cuComplex.h"

__device__ float GetMaxValue(float a, float b)
{
    if (a < b) {
        return a;
    } else {
        return b;
    }
}
__global__ void SoftMax(float *input, float *output, int len)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < len) {
        float max_value = input[idx];
        for (int i = 0; i < len; i++) {
            max_value = GetMaxValue(max_value, input[i]);
        }

        float sum = 0.0;
        for (int i = 0; i < len; i++) {
            sum += __expf(input[i]-max_value);
        }
        output[idx] = __expf(input[idx] - max_value) / sum;
    }
}
