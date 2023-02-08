#include <stdio.h>
#include <stdlib.h>
#include "gauss_initial.h"

void gauss_initial(const double* r2_ptr, const double* t1_ptr, const double* t2_ptr, const double* t3_ptr, const double* mu_ptr, double* a_ptr, double* c_ptr)
{
    // difference between times of observations
    double tau = *t3_ptr - *t1_ptr;
    double tau_3 = *t3_ptr - *t2_ptr;
    double tau_1 = *t1_ptr - *t2_ptr;

    // multiplication is slightly more efficient than division here
    double tr = *r2_ptr * *r2_ptr * *r2_ptr;
    double u = *mu_ptr / tr;

    // more order of operations optimization
    a_ptr[0] = tau_3 / tau;
    a_ptr[1] = (tau * tau - tau_3 * tau_3) * tau_3 / 6 / tau;
    a_ptr[2] = -tau_1 / tau;
    a_ptr[3] = -((tau * tau - tau_1 * tau_1) * tau_1 / 6 / tau);
    c_ptr[0] = a_ptr[0] + a_ptr[1] * u;
    c_ptr[1] = -1;
    c_ptr[2] = a_ptr[2] + a_ptr[3] * u;
}