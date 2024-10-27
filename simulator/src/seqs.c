#include "tree.h"
#include "utils.h"
#include <assert.h>

void allocSeqs(pTreeNode p, int len) {
    if (p == NULL) return;
    
    // allocate space for sequence
    p->sequence = (int *)malloc(len * sizeof(int));
    if (p->sequence == NULL) {
        printf("Failed to allocate sequence.\n");
        exit(1);
    }

    allocSeqs(p->llink, len);
    allocSeqs(p->rlink, len);
}

void simChars(pTreeNode p, double base, int hetero, int pos, double *pi) {
    /* simulate k state characters at pos(ition) */
    int i, astate;
    double c, x, dist, beta, trProb[2];
    
    if (p->alink == NULL) {
        // initialize character at the root
        c = rndu();
        for (x = pi[0], i = 0; c > x; i++)
            x += pi[i+1];
        p->sequence[pos] = i;
    }
    else {
        // evolve from ancestral node to current node
        astate = p->alink->sequence[pos];
        if (hetero == YES)
            dist = p->brl * base * p->rates[pos];
        else
            dist = p->brl * base * p->rates[0];

        beta = 0.0;
        for (i = 0; i < 2; i++)
            beta += pi[i] * pi[i];
        beta = 1.0 / (1 - beta);

        // calculate transition probs based on ancestral state and distance
        for (i = 0; i < 2; i++) {
            if (astate == i)  // no change
                trProb[i] = exp(-beta * dist) + pi[i] * (1 - exp(-beta * dist));
            else
                trProb[i] = pi[i] * (1 - exp(-beta * dist));  // change
        }
        
        // simulate the end state
        c = rndu();
        for (x = trProb[0], i = 0; c > x; i++)
            x += trProb[i+1];
        p->sequence[pos] = i;
    }
    
    if (p->llink != NULL)
        simChars(p->llink, base, hetero, pos, pi);
    
    if (p->rlink != NULL)
        simChars(p->rlink, base, hetero, pos, pi);
}

int isConstChar(pTreeNode* tips, int ntips, int pos) {
    int i;
    
    for (i = 1; i < ntips; i++) {
        if (tips[i]->sequence[pos] != tips[0]->sequence[pos])
            return 0;
    }
    return 1; // when constant
}

void simulateData(pPhyTree tree, int len, int hetero, double alpha) {
    int i, k, l;
    double pi[2], g[2], sum_g;
    
    assert(len > 0);
    
    allocSeqs(tree->root, len);
    tree->nsites = len;
    
    /* simulate discrete characters given the tree */
    k = 2;  // only binary characters for now
    for (l = 0; l < len; l++) {
        // generate base frequencies
        if (alpha > 0) {
            // from symDir(alpha) distribution
            sum_g = 0.0;
            for (i = 0; i < k; i++) {
                g[i] = rndGamma(alpha, 1);
                sum_g += g[i];
            }
            for (i = 0; i < k; i++)
                pi[i] = g[i] / sum_g;
        } else {
            for (i = 0; i < k; i++)
                pi[i] = 1.0 / k;
        }
        
        /* keep only variable characters at the tips */
        do {
            simChars(tree->root, tree->rbase, hetero, l, pi);
        }
        while (isConstChar(tree->tips, tree->ntips, l));
    }
}

void simulateData_corr(pPhyTree tree, int len, int hetero, double alpha) {
    
}
