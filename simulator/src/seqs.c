#include "tree.h"
#include "utils.h"
#include <assert.h>

void allocSeqs(pTreeNode p, int len) {
    if (p == NULL) return;
    
    // allocate space for sequence
    p->sequence = (int *)calloc(len, sizeof(int));
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

void baseFreq(int k, double alpha, double *pi) {
    int i;
    double sum_g, g[k];
    
    // generate base frequencies
    if (alpha > 0) {  // from symDir(a)
        sum_g = 0.0;
        for (i = 0; i < k; i++) {
            g[i] = rndGamma(alpha, 1);
            sum_g += g[i];
        }
        for (i = 0; i < k; i++)
            pi[i] = g[i] / sum_g;
    } else {
        for (i = 0; i < k; i++)
            pi[i] = 1.0 / k;  // equal frequencies
    }
}

void simChars(pTreeNode p, double base, int pos, int k, double *pi) {
    /* simulate discrete characters at pos(ition) */
    int i, astate;
    double u, x, dist, beta, trProb[k];
    
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
        dist = p->brl * base * p->rates[pos];
        
        beta = 0.0;
        for (i = 0; i < k; i++)
            beta += pi[i] * pi[i];
        beta = 1.0 / (1 - beta);

        // calculate transition probs based on ancestral state and distance
        for (i = 0; i < k; i++) {
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
        simChars(p->llink, base, pos, k, pi);
    
    if (p->rlink != NULL)
        simChars(p->rlink, base, pos, k, pi);
}

void simulateData(pPhyTree tree, int len, double alpha) {
    /* simulate discrete characters (binary for now) given the tree */
    int l;
    double pi[2];
    
    assert(len > 0);
    
    allocSeqs(tree->root, len);
    tree->nsites = len;
    
    for (l = 0; l < len; l++) {
        // generate base frequencies
        baseFreq(2, alpha, pi);
        
        /* keep only variable characters at the tips */
        do {
            simChars(tree->root, tree->rbase, l, 2, pi);
        }
        while (isConstChar(tree->tips, tree->ntips, l));
    }
}


void simChars_corr(pTreeNode p, double base, int pos,
                   double pi[8], double Q[8][8]) {
    /* simulate correlated binary characters at pos(ition) */
    int i, j, astate;
    double u, x, t, dist;

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
        dist = p->brl * base * p->rates[pos];
        
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
            i = j - 1;
            t += rndExp(-Q[i][i]);
        }
        // save the end state
        p->sequence[pos] = i;
    }
    
    if (p->llink != NULL)
        simChars_corr(p->llink, base, pos, pi, Q);
    
    if (p->rlink != NULL)
        simChars_corr(p->rlink, base, pos, pi, Q);
}

void simulateData_corr(pPhyTree tree, int len, int size, double aD, double aG) {
    /* simulate discrete characters (binary for now) given the tree;
       use GTR-like model for each group of correlated characters */
    int i, j, l;
    double sum, pi[8]={0}, e[12]={0}, Q[8][8]={{0}};
    
    allocSeqs(tree->root, len+size);
    tree->nsites = len;
    
    if (size == 2) {
        /* simulate double-correlated characters
             [. a b 0][pi_1 0    0   0 ]
         Q = [a . 0 c][ 0  pi_2  0   0 ]
             [b 0 . d][ 0   0  pi_3  0 ]
             [0 c d .][ 0   0    0 pi_4] */
        for (l = 0; l < len; l += 2) {
            // generate base frequencies
            baseFreq(4, aD, pi);
            
            // generate a, b, c, d from gamma distribution
            for (i = 0; i < 4; i++)
                e[i] = rndGamma(aG, aG);
            // set up the Q matirx
            Q[0][1] = e[0] * pi[1];  Q[0][2] = e[1] * pi[2];
            Q[1][0] = e[0] * pi[0];  Q[1][3] = e[2] * pi[3];
            Q[2][0] = e[1] * pi[0];  Q[2][3] = e[3] * pi[3];
            Q[3][1] = e[2] * pi[1];  Q[3][2] = e[3] * pi[2];
            Q[0][0] = -Q[0][1] -Q[0][2];
            Q[1][1] = -Q[1][0] -Q[1][3];
            Q[2][2] = -Q[2][0] -Q[2][3];
            Q[3][3] = -Q[3][1] -Q[3][2];
            // and rescale the average rate to 2.0
            sum = 0.0;
            for(i = 0; i < 4; i++)
                sum -= pi[i] * Q[i][i];
            for(i = 0; i < 4; i++)
                for(j = 0; j < 4; j++)
                    Q[i][j] = Q[i][j] * 2.0 / sum;
            
            // start evolving from the root to the tips,
            // and keep only variable characters at the tips
            do {
                simChars_corr(tree->root, tree->rbase, l, pi, Q);
                
                // convert 0, 1, 2, 3 to 00, 01, 10, 11
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
                                   tree->tips[i]->sequence[l], l+1,
                                   tree->tips[i]->name);
                            exit(1);
                            break;
                    }
                }
            } while (isConstChar(tree->tips, tree->ntips, l) ||
                     isConstChar(tree->tips, tree->ntips, l+1));
        }
    }
    else {
        /* simulate triple-correlated characters
             [. a b 0 i 0 0 0][pi_1 0   0   0    0   0   0   0 ]
             [a . 0 c 0 j 0 0][ 0  pi_2 0   0    0   0   0   0 ]
             [b 0 . d 0 0 k 0][ 0   0  pi_3 0    0   0   0   0 ]
         Q = [0 c d . 0 0 0 l][ 0   0   0  pi_4  0   0   0   0 ]
             [i 0 0 0 . e f 0][ 0   0   0   0  pi_5  0   0   0 ]
             [0 j 0 0 e . 0 g][ 0   0   0   0    0 pi_6  0   0 ]
             [0 0 k 0 f 0 . h][ 0   0   0   0    0   0 pi_7  0 ]
             [0 0 0 l 0 g h .][ 0   0   0   0    0   0   0 pi_8] */
        for (l = 0; l < len; l += 3) {
            // generate base frequencies
            baseFreq(8, aD, pi);
            
            // generate 12 ex. rates from gamma distribution
            for (i = 0; i < 12; i++)
                e[i] = rndGamma(aG, aG);
            // set up the Q matirx
            Q[0][1] = e[0] * pi[1]; Q[0][2] = e[1] * pi[2]; Q[0][4] = e[8] * pi[4];
            Q[1][0] = e[0] * pi[0]; Q[1][3] = e[2] * pi[3]; Q[1][5] = e[9] * pi[5];
            Q[2][0] = e[1] * pi[0]; Q[2][3] = e[3] * pi[3]; Q[2][6] = e[10]* pi[6];
            Q[3][1] = e[2] * pi[1]; Q[3][2] = e[3] * pi[2]; Q[3][7] = e[11]* pi[7];
            Q[4][0] = e[8] * pi[0]; Q[4][5] = e[4] * pi[5]; Q[4][6] = e[5] * pi[6];
            Q[5][1] = e[9] * pi[1]; Q[5][4] = e[4] * pi[4]; Q[5][7] = e[6] * pi[7];
            Q[6][2] = e[10]* pi[2]; Q[6][4] = e[5] * pi[4]; Q[6][7] = e[7] * pi[7];
            Q[7][3] = e[11]* pi[3]; Q[7][5] = e[6] * pi[5]; Q[7][6] = e[7] * pi[6];
            Q[0][0] = -Q[0][1] -Q[0][2] -Q[0][4];
            Q[1][1] = -Q[1][0] -Q[1][3] -Q[1][5];
            Q[2][2] = -Q[2][0] -Q[2][3] -Q[2][6];
            Q[3][3] = -Q[3][1] -Q[3][2] -Q[3][7];
            Q[4][4] = -Q[4][0] -Q[4][5] -Q[4][6];
            Q[5][5] = -Q[5][1] -Q[5][4] -Q[5][7];
            Q[6][6] = -Q[6][2] -Q[6][4] -Q[6][7];
            Q[7][7] = -Q[7][3] -Q[7][5] -Q[7][6];
            // and rescale the average rate to 3.0
            sum = 0.0;
            for(i = 0; i < 8; i++)
                sum -= pi[i] * Q[i][i];
            for(i = 0; i < 8; i++)
                for(j = 0; j < 8; j++)
                    Q[i][j] = Q[i][j] * 3.0 / sum;
            
            // start evolving from the root to the tips,
            // and keep only variable characters at the tips
            do {
                simChars_corr(tree->root, tree->rbase, l, pi, Q);
                
                // convert 0,   1,   2,   3,   4,   5,   6,   7
                //      to 000, 001, 010, 011, 100, 101, 110, 111
                for (i = 0; i < tree->ntips; i++) {
                    switch (tree->tips[i]->sequence[l]) {
                        case 0:
                            tree->tips[i]->sequence[l+1] = 0;
                            tree->tips[i]->sequence[l+2] = 0;
                            break;
                        case 1:
                            tree->tips[i]->sequence[l]   = 0;
                            tree->tips[i]->sequence[l+1] = 0;
                            tree->tips[i]->sequence[l+2] = 1;
                            break;
                        case 2:
                            tree->tips[i]->sequence[l]   = 0;
                            tree->tips[i]->sequence[l+1] = 1;
                            tree->tips[i]->sequence[l+2] = 0;
                            break;
                        case 3:
                            tree->tips[i]->sequence[l]   = 0;
                            tree->tips[i]->sequence[l+1] = 1;
                            tree->tips[i]->sequence[l+2] = 1;
                            break;
                        case 4:
                            tree->tips[i]->sequence[l]   = 1;
                            tree->tips[i]->sequence[l+1] = 0;
                            tree->tips[i]->sequence[l+2] = 0;
                            break;
                        case 5:
                            tree->tips[i]->sequence[l]   = 1;
                            tree->tips[i]->sequence[l+1] = 0;
                            tree->tips[i]->sequence[l+2] = 1;
                            break;
                        case 6:
                            tree->tips[i]->sequence[l]   = 1;
                            tree->tips[i]->sequence[l+1] = 1;
                            tree->tips[i]->sequence[l+2] = 0;
                            break;
                        case 7:
                            tree->tips[i]->sequence[l]   = 1;
                            tree->tips[i]->sequence[l+1] = 1;
                            tree->tips[i]->sequence[l+2] = 1;
                            break;
                        default:
                            printf("Unknown state %d at %d-th character of taxon %s\n",
                                   tree->tips[i]->sequence[l], l+1,
                                   tree->tips[i]->name);
                            exit(1);
                            break;
                    }
                }
            } while (isConstChar(tree->tips, tree->ntips, l)   ||
                     isConstChar(tree->tips, tree->ntips, l+1) ||
                     isConstChar(tree->tips, tree->ntips, l+2));
        }
    }
}
