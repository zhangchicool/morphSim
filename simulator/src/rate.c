#include "tree.h"
#include "utils.h"
#include <assert.h>

void allocRates(pTreeNode p, int len) {
    if (p == NULL) return;
    
    // allocate space for rates
    p->rates = (double *)calloc(len, sizeof(double));
    if (p->rates == NULL) {
        printf("Failed to allocate rates.\n");
        exit(1);
    }

    allocRates(p->llink, len);
    allocRates(p->rlink, len);
}

void simulateRates(pPhyTree tree, int len, int npart, double base, double var) {
    /* simulate branch rates under the given clock model */
    int  i, l, n, m;
    pTreeNode p;
    double mu, sigma, rate;
    
    assert(npart > 0 && npart <= len);

    /* base clock rate and variance */
    tree->rbase = base;
    tree->rvar  = var;
    allocRates(tree->root, len);
    
    for (i = 0; i < 2 * tree->ntips -2; i++) {
        if (i < tree->ntips)
            p = tree->tips[i];
        else
            p = tree->ints[i - tree->ntips];
        
        if (var > 0.0) {
            /* independent lognormal rates */
            sigma = sqrt(log(var + 1.0));
            mu = - sigma * sigma / 2.0;
            
            m = len / npart; // number of chars per partition
            for (n = 0; n < npart; n++) {
                /* same (linked) rate within each partition */
                rate = rndLogNormal(mu, sigma);
                if (n < npart - 1) {
                    for (l = n*m; l < (n+1)*m; l++)
                        p->rates[l] = rate;
                } else {
                    for (l = n*m; l < len; l++)
                        p->rates[l] = rate;
                }
            }
        }
        else {
            /* strict clock */
            for (l = 0; l < len; l++)
                p->rates[l] = 1.0;
        }
    }
}
