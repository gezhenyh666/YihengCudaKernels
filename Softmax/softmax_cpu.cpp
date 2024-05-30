#include <stdio.h>
#include <math.h>

float GetMaxValue(const float *input, int len)
{
    float max_value = input[0];
    for (size_t i = 1; i < len; i++) {
        if (max_value < input[i]) 
        {
            max_value = input[i];
        }
    }
    return max_value;
}

void SoftMaxCpu(const float *input, float* output, int len)
{
    float sum = 0.0;
    float max_value = GetMaxValue(input, len);
    for (size_t i = 0; i < len; i++) {
        sum += std::exp(input[i] - max_value);
    }

    for (size_t i = 0; i < len; i++) {
        output[i] = std::exp(input[i] - max_value) / sum;
    }
}

void PrintOutput(float *input, int len) 
{
    for (size_t i = 0; i < len; i++) {
        printf("output data is: %f\n", input[i]);
    }
}

int main()
{
    float test_data_1[5] = {1, 2, 3, 4, 5};
    float test_data_2[5] = {1, 2, 3, 4, 10000};
    float test_data_3[5] = {1, 2, 3, 4, 0.00001};
    float output1[5];
    float output2[5];
    float output3[5];
    float output4[5];
    float output5[5];

    SoftMaxCpu(test_data_1, output1, 5);
    SoftMaxCpu(test_data_2, output2, 5);
    SoftMaxCpu(test_data_3, output3, 5);
    PrintOutput(output1, 5);
    PrintOutput(output2, 5);
    PrintOutput(output3, 5);

    return 0;
}