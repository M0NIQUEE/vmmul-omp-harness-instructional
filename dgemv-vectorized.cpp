const char *dgemv_desc = "Vectorized implementation of matrix-vector multiply.";

/*
 * This routine performs a dgemv operation
 * Y :=  A * X + Y
 * where A is n-by-n matrix stored in row-major format, and X and Y are n by 1 vectors.
 * On exit, A and X maintain their input values.
 */

/*
https://www.jsums.edu/robotics/files/2016/12/FECS17_Proceedings-FEC3555.pdf 
also some help from chatgpt
resources from LECTURES 23,24,25
*/
void my_dgemv(int n, double *A, double *x, double *y) {
    for (int i = 0; i < n; ++i) {
        double sum = 0.0;
        double *multi = A + i * n;

        for (int j = 0; j < n; ++j) {
            sum += multi[j] * x[j];
        }

        y[i] += sum;
    }
}
