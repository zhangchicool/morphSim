#include "tree.h"
#include "utils.h"
#include <assert.h>

void allocRates(pTreeNode p, int len) {
    if (p == NULL) return;
    
    // allocate space for rates
    p->rates = (double *)malloc(len * sizeof(double));
    if (p->rates == NULL) {
        printf("Failed to allocate rates.\n");
        exit(1);
    }

    allocRates(p->llink, len);
    allocRates(p->rlink, len);
}

void simulateRates(pPhyTree tree, int len, double base, double var) {
    /* simulate branch rates under the given clock model */
    int  i, l;
    pTreeNode p;
    double mu, sigma;
    
    assert(len > 0);

    /* base clock rate and variance */
    tree->rbase = base;
    tree->rvar  = var;
    allocRates(tree->root, len);

    /* generate branch rates */
    for (i = 0; i < 2 * tree->ntips -2; i++) {
        if (i < tree->ntips)
            p = tree->tips[i];
        else
            p = tree->ints[i - tree->ntips];
        
        if (var > 0.0) {
            /* independent lognormal clock */
            sigma = sqrt(log(var + 1.0));
            mu = - sigma * sigma / 2.0;
            for (l = 0; l < len; l++)
                p->rates[l] = rndLogNormal(mu, sigma);
        }
        else {
            /* strict clock */
            for (l = 0; l < len; l++)
                p->rates[l] = 1.0;
        }
    }
}
