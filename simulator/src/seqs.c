#include "tree.h"
#include "seqs.h"
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

void simChars(pTreeNode p, double brate, int k, int pos) {
    /* simulate k state characters at pos(ition) */
    int i, astate;
    double c, x, dist, trProb[k];
    
    if (p->alink == NULL) {
        // initialize character at the root
        c = rndu();
        for (x = 1.0/k, i = 0; c > x; i++) {
            x += 1.0/k;
        }
        p->sequence[pos] = i;
    } else {
        // evolve from ancestral node to current node
        astate = p->alink->sequence[pos];
        dist = p->brlen * brate * p->rate;
                
        // calculate transition probs based on ancestral state and distance
        for (i = 0; i < k; i++) {
            if (astate == i) {
                trProb[i] = 1.0/k + (k-1.0)/k * exp(-k/(k-1.0) * dist); // no change
            } else {
                trProb[i] = 1.0/k - 1.0/k * exp(-k/(k-1.0) * dist);     // change
            }
        }
        
        // simulate the end state
        c = rndu();
        for (x = trProb[0], i = 0; c > x; i++) {
            x += trProb[i+1];
        }
        p->sequence[pos] = i;
    }
    
    if (p->llink != NULL) {
        simChars(p->llink, brate, k, pos);
    }
    if (p->rlink != NULL) {
        simChars(p->rlink, brate, k, pos);
    }
}

int isConstChar(pTreeNode* tips, int ntips, int pos) {
    int i;
    
    for (i = 1; i < ntips; i++) {
        if (tips[i]->sequence[pos] != tips[0]->sequence[pos])
            return 0;
    }
    return 1; // when constant
}

void simulateData(pPhyTree tree, int len) {
    int i, k, n2st, n3st, n4st, n5st;

    // assuming rooted tree
    assert(tree->type == ROOTED && tree->root != NULL);
    
    allocSeqs(tree->root, len);
    tree->nsites = len;
    
    n2st = (int)(len * 0.4);
    n3st = (int)(len * 0.3);
    n4st = (int)(len * 0.2);
    n5st = len - n2st - n3st;

    // simulate discrete characters given the tree */
    for (i = 0; i < len; i++) {
        if (i < n2st) {
            k = 2;
        } else if (i < n2st+n3st) {
            k = 3;
        } else if (i < len-n5st) {
            k = 4;
        } else {
            k = 5;
        }
        // keep only variable characters at the tips
        do {
            simChars(tree->root, tree->baserate, k, i);
        } while (isConstChar(tree->tips, tree->ntips, i));
    }
}
