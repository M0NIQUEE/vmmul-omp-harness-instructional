#include <iostream>
#include <math.h>
#include <chrono>
 
// function to add the elements of two arrays
__global__
void add(int n, float *x, float *y)
{
 int index = blockIdx.x * blockDim.x + threadIdx.x;
 int stride = blockDim.x * gridDim.x;
 for(int i = index; i < n; i += stride)
	y[i] = x[i]+y[i];
}
 
int main(void)
{
 int N = 1<<29; // 1M elements
 
// Allocating unified memory
float *x, *y;
cudaMallocManaged(&x, N*sizeof(float));
cudaMallocManaged(&y, N*sizeof(float));

 // initialize x and y arrays on the st
 for (int i = 0; i < N; i++) {
   x[i] = 1.0f;
   y[i] = 2.0f;
 }

int blockSize = 256;
int numBlocks = (N + blockSize -1)/ blockSize;

std::cout<<"Number of thread blocks used in this run: " << blockSize;

add<<<numBlocks, blockSize>>>(N, x, y);


cudaDeviceSynchronize();

 // Check for errors (all values should be 3.0f)
 float maxError = 0.0f;
 for (int i = 0; i < N; i++)
   maxError = fmax(maxError, fabs(y[i]-3.0f));
 std::cout << "Max error: " << maxError << std::endl;
 
 // Free memory
 cudaFree(x);
 cudaFree(y);
 
 return 0;
}
