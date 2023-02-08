#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "minimum_energy_solver.h"
# define PI 3.14159265358979

void minimum_energy_solver(const double* r1_ptr, const double* r2_ptr, const double* cosdTheta_ptr, const double* mu_ptr, const int n, const int dThetaPi, double* a_min_ptr, double* dt_min_ptr)
{
    // chord length
    double c = sqrt(*r1_ptr * *r1_ptr + *r2_ptr * *r2_ptr - 2 * *r1_ptr * *r2_ptr * *cosdTheta_ptr);
    // semi parameter
    double s = (*r1_ptr + *r2_ptr + c) / 2;
    // semi parameter divided by 2
    *a_min_ptr = s / 2;
    // beta angle
    double beta = 2 * asin(sqrt((s - c)/s));
    // quadrant issues
    if (dThetaPi) {
        beta = -beta;
    }
    // minimum energy time
    *dt_min_ptr = pow(*a_min_ptr, 1.5) * ((2 * n + 1) * PI - beta + sin(beta)) / sqrt(*mu_ptr);
}