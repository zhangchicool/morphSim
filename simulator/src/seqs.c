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

int isConstChar(pTreeNode* tips, int ntips, int pos) {
    int i;
    
    for (i = 1; i < ntips; i++) {
        if (tips[i]->sequence[pos] != tips[0]->sequence[pos])
            return 0;
    }
    return 1; // when constant
}

void simChars(pTreeNode p, double base, int hetero, int pos, double *pi) {
    /* simulate binary characters at pos(ition) */
    int i, astate;
    double u, x, dist, beta, trProb[2];
    
    if (p->alink == NULL) {
        // initialize character at the root
        u = rndu();
        for (x = pi[0], i = 0; u > x; i++)
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
        u = rndu();
        for (x = trProb[0], i = 0; u > x; i++)
            x += trProb[i+1];
        p->sequence[pos] = i;
    }
    
    if (p->llink != NULL)
        simChars(p->llink, base, hetero, pos, pi);
    
    if (p->rlink != NULL)
        simChars(p->rlink, base, hetero, pos, pi);
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


void simChars_pair(pTreeNode p, double base, int hetero, int pos,
                   double pi[4], double Q[4][4]) {
    /* simulate a pair of (correlated) binary characters at pos(ition) */
    int i, j, astate;
    double u, x, t, dist;

    if (p->alink == NULL) {
        // initialize character at the root
        u = rndu();
        for (x = pi[0], i = 0; u > x; i++)
            x += pi[i+1];
        // use 0, 1, 2, 3 to represent 00, 01, 10, 11
        p->sequence[pos] = i;
    }
    else {
        // evolve from ancestral node to current node
        astate = p->alink->sequence[pos];
        if (hetero == YES)
            dist = p->brl * base * p->rates[pos];
        else
            dist = p->brl * base * p->rates[0];
        
        // generating exponential waiting times and using the jump chain
        i = astate;
        // the waiting time until a jump (change) of state has an exponential
        // distribution with rate (intensity) q_i = -q_{ii}
        t = rndExp(-Q[i][i]);
        while (t < dist) {
            // when a jump occurs, the chain moves to the alternative states
            // j (!= i) with probability q_{ij}/q_i
            u = rndu();
            x = 0.;
            for (j = 0; u > x; j++) {
                if (j != i)
                    x += Q[i][j]/(-Q[i][i]);
            }
            i = j;
            t += rndExp(-Q[i][i]);
        }
        // save the end state
        p->sequence[pos] = i;
    }
    
    if (p->llink != NULL)
        simChars_pair(p->llink, base, hetero, pos, pi, Q);
    
    if (p->rlink != NULL)
        simChars_pair(p->rlink, base, hetero, pos, pi, Q);
}

/* use GTR model for each pair of correlated characters
       [  .    a*pi_C b*pi_A   0   ]   [. a b 0][pi_T 0    0   0 ]
   Q = [a*pi_T   .      0    e*pi_G] = [a . 0 e][ 0  pi_C  0   0 ]
       [b*pi_T   0      .    f*pi_G]   [b 0 . f][ 0   0  pi_A  0 ]
       [  0    e*pi_C f*pi_A   .   ]   [0 e f .][ 0   0    0 pi_G]
 */
void simulateData_corr(pPhyTree tree, int len, int hetero, double alpha) {
    int i, j, l;
    double pi[4], af[4], g[4], sum, Q[4][4]={{0}};
    
    allocSeqs(tree->root, len);
    tree->nsites = len;
    
    /* simulate each pair of characters given the tree */
    for (l = 0; l < len; l += 2) {
        // generate base frequencies
        if (alpha > 0) {
            // from symDir(alpha) distribution
            sum = 0.0;
            for (i = 0; i < 4; i++) {
                g[i] = rndGamma(alpha, 1);
                sum += g[i];
            }
            for (i = 0; i < 4; i++)
                pi[i] = g[i] / sum;
        } else {
            for (i = 0; i < 4; i++)
                pi[i] = 0.25;
        }
        // generate a, b, e, f (c = d = 0)
        for (i = 0; i < 4; i++)
            af[i] = rndExp(1.0);
        
        // set up the Q matirx and rescale the average rate to 2.0
        Q[1][0] = af[0] * pi[0];
        Q[2][0] = af[1] * pi[0];
        Q[0][1] = af[0] * pi[1];
        Q[3][1] = af[2] * pi[1];
        Q[0][2] = af[1] * pi[2];
        Q[3][2] = af[3] * pi[2];
        Q[1][3] = af[2] * pi[3];
        Q[2][3] = af[3] * pi[3];
        Q[0][0] = -Q[0][1] - Q[0][2];
        Q[1][1] = -Q[1][0] - Q[1][3];
        Q[2][2] = -Q[2][0] - Q[2][3];
        Q[3][3] = -Q[3][1] - Q[3][2];
        sum = 0.0;
        for(i = 0; i < 4; i++)
            sum -= pi[i] * Q[i][i];
        for(i = 0; i < 4; i++)
            for(j = 0; j < 4; j++)
                Q[i][j] = Q[i][j] * 2.0 / sum;
        
        do {
            simChars_pair(tree->root, tree->rbase, hetero, l, pi, Q);
        
            // convert T, C, A, G to 00, 01, 10, 11
            for (i = 0; i < tree->ntips; i++) {
                switch (tree->tips[i]->sequence[l]) {
                    case 0:
                        tree->tips[i]->sequence[l+1] = 0;
                        break;
                    case 1:
                        tree->tips[i]->sequence[l]   = 0;
                        tree->tips[i]->sequence[l+1] = 1;
                        break;
                    case 2:
                        tree->tips[i]->sequence[l]   = 1;
                        tree->tips[i]->sequence[l+1] = 0;
                        break;
                    case 3:
                        tree->tips[i]->sequence[l]   = 1;
                        tree->tips[i]->sequence[l+1] = 1;
                        break;
                    default:
                        printf("Unknown state %d at %d-th character of taxon %s\n",
                               tree->tips[i]->sequence[l], l+1, tree->tips[i]->name);
                        exit(1);
                        break;
                }
            }
        }   // keep only variable characters at the tips
        while (isConstChar(tree->tips, tree->ntips, l) ||
               isConstChar(tree->tips, tree->ntips, l+1));
    }
}
