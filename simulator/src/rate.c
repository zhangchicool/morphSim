#include "tree.h"
#include "rate.h"
#include "utils.h"
#include <assert.h>

void simulateRates(pPhyTree tree, int clock, double var) {
    /* simulate branch rates under the given clock model */
    int  i, ntips;
    pTreeNode p;
    double mu, sigma;
    
    // assuming rooted tree
    assert(tree->type == ROOTED);
    
    /* base clock rate */
    tree->baserate = 1.0;
    
    /* generate branch rates */
    ntips = tree->ntips;
    for (i = 0; i < 2*ntips -2; i++) {
        if (i < ntips)
            p = tree->tips[i];
        else
            p = tree->ints[i-ntips];
        
        if (clock == IGR) {
            p->rate = rndGamma(1.0/var, 1.0/var);
        }
        else if (clock == ILN) {
            sigma = sqrt(log(var + 1.0));
            mu = - sigma * sigma / 2.0;
            p->rate = rndLogNormal(mu, sigma);
        }
        else if (clock == NORM) {
            sigma = sqrt(var);
            do {
                mu = rndNormal(1.0, sigma);
            } while (mu <= 0.0);
            p->rate = mu;
        }
        else {
            p->rate = 1.0; // strict clock
        }
        // printf("%s:%lf[%lf]\n", p->name, p->brl, p->rate);
    }
}

void writeRootedTreeRates(FILE *fp, pTreeNode p, pTreeNode root, double brate) {
    /* newick tree with rates */
    if (p == NULL) return;
    if (p->llink != NULL)  // && p->rlink != NULL
        fprintf(fp, "(");
    else
        fprintf(fp, "%s:%.10lf[&B MixedBrlens %.10lf]", p->name, p->brlen * brate, p->brlen * brate * p->rate);
    writeRootedTreeRates(fp, p->llink, root, brate);
    if (p->llink != NULL)  // && p->rlink != NULL
        fprintf(fp, ",");
    writeRootedTreeRates(fp, p->rlink, root, brate);
    if (p == root)
        fprintf(fp, ")");
    else if (p->llink != NULL)
        fprintf(fp, "):%.10lf[&B MixedBrlens %.10lf]", p->brlen * brate, p->brlen * brate * p->rate);
}
