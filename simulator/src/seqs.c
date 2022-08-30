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

void simChars(pTreeNode p, double base, int hetero, int pos, int k, double *pi, double beta) {
    /* simulate k state characters at pos(ition) */
    int i, astate;
    double c, x, dist, trProb[k];
    
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

        // calculate transition probs based on ancestral state and distance
        for (i = 0; i < k; i++) {
            if (astate == i)
                trProb[i] = exp(-beta * dist) + pi[i] * (1 - exp(-beta * dist)); // no change
            else
                trProb[i] = pi[i] * (1 - exp(-beta * dist));                     // change
        }
        
        // simulate the end state
        c = rndu();
        for (x = trProb[0], i = 0; c > x; i++)
            x += trProb[i+1];
        p->sequence[pos] = i;
    }
    
    if (p->llink != NULL)
        simChars(p->llink, base, hetero, pos, k, pi, beta);
    
    if (p->rlink != NULL)
        simChars(p->rlink, base, hetero, pos, k, pi, beta);
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
    int i, k, l, n2st, n3st, n4st;
    double pi[4], g[4], sum_g, beta;
    
    assert(len > 0);
    
    allocSeqs(tree->root, len);
    tree->nsites = len;
    
    /* binary to 4-state characters with proportions of 0.5, 0.3, 0.2 */
    n2st = (int)(len * 0.5);
    n3st = (int)(len * 0.3);
    n4st = len - n2st - n3st;

    /* simulate discrete characters given the tree */
    for (l = 0; l < len; l++) {
        if (l < n2st)
            k = 2;
        else if (l < n2st+n3st)
            k = 3;
        else
            k = 4;
        
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
        
        beta = 0.0;  // used in transition prob calculation
        for (i = 0; i < k; i++)
            beta += pi[i] * pi[i];
        beta = 1.0 / (1 - beta);

        /* keep only variable characters at the tips */
        do {
            simChars(tree->root, tree->rbase, hetero, l, k, pi, beta);
        }
        while (isConstChar(tree->tips, tree->ntips, l));
    }
}
