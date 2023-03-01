#include "tree.h"
#include "utils.h"
#include <assert.h>

pPhyTree extractFBDTree(pPhyTree fullTree);

void showTreeInfo(FILE *fp, pPhyTree tree) {
    int i, n, m, k;
    
    fprintf(fp, "TreeInfo ");
    fprintf(fp, "%lf\t", tree->height);
    fprintf(fp, "%lf\t", tree->length);

    n = m = k = 0;
    for (i = 0; i < tree->ntips; i++) {
        if (tree->tips[i]->age < 1E-8)
            n++;  // number of extant taxa
        else if (tree->tips[i]->brl > 0.0)
            m++;  // number of tip fossils
        else
            k++;  // number of anc fossils
    }
    fprintf(fp, "%d\t%d\t%d\n", n, m, k);
}

/* sample fossils on tree with rate psi
 | sample extant taxa randomly with probability rho
 | return sampled FBD tree
 */
pPhyTree sampleFossilAndExtantRnd(pPhyTree tree, double psi, double rho) {
    int    i, n, m;
    double l, brl, suml;
    pTreeNode p, q, r, s;
    pPhyTree fbdt;
    
    n = 0;  // number of sampled extant taxa
    /* sample extant taxa with prob rho */
    for (i = 0; i < tree->ntips; i++) {
        s = tree->tips[i];
        if (s->age < 1E-8 && rndu() < rho) {
            s->marked = YES;
            n++;
        }
    }
    
    m = 0;  // number of sampled fossils
    if (psi > 0) {
        /* sample fossils on each branch */
        for (i = 0; i < 2 * tree->ntips -2; i++) {
            if (i < tree->ntips)
                s = tree->tips[i];
            else
                s = tree->ints[i - tree->ntips];
            p = s->alink;
            brl = s->brl;
            
            l = suml = rndExp(psi);
            while (suml < brl) {
                q = newNode();
                r = newNode();
                r->marked = YES;
                m++;
                
                /* relationships and brls */
                if (p->llink == s)
                    p->llink = q;
                else
                    p->rlink = q;
                q->alink = p;
                q->llink = s;
                q->rlink = r;
                r->alink = q;
                s->alink = q;
                sprintf(r->name, "f%d", m);
                q->brl = l;
                r->brl = 0.0;
                q->age = p->age -l;
                r->age = p->age -l;
                s->brl -= l;
                
                /* move on */
                l = rndExp(psi);
                suml += l;
                p = q;
            }
        }
    }
    
    if (m + n == 0) {
        printf("Warning: nothing sampled!\n");
        return NULL;
    }
    else {
        /* update #tips and node array */
        updateNodeArray(tree);
    }
    // writeTree(stdout, tree);

    /* mark all sampled nodes */
    for (i = 0; i < tree->ntips; i++) {
        p = tree->tips[i];
        if (p->marked == YES) {
            while (p != tree->root) {
                p = p->alink;
                if (p->marked == YES) break;
                else p->marked = YES;
            }
        }
    }
    
    /* extract the sampled tree from the complete tree */
    fbdt = extractFBDTree(tree);
    // writeTree(stdout, fbdt);

    return fbdt;
}

/* sample fossils on tree with rate psi
 | sample extant taxa diversified with proportion rho
 | return sampled FBD tree
 */
pPhyTree sampleFossilAndExtantDiv(pPhyTree tree, double psi, double rho) {
    int    i, j, k, nE, n, m, brk;
    double l, brl, suml;
    pTreeNode p, q, r, s, *intNode, *extNode;
    pPhyTree fbdt;
    
    intNode = (pTreeNode *)malloc(tree->ntips * sizeof(pTreeNode));
    extNode = (pTreeNode *)malloc(tree->ntips * sizeof(pTreeNode));

    /* first, mark out extant taxa tree, and store the marked nodes */
    for (nE = 0, i = 0; i < tree->ntips; i++) {
        s = tree->tips[i];
        if (s->age < 1E-8) {
            extNode[nE++] = s;
            s->marked = YES;
            while (s != tree->root) {
                s = s->alink;
                s->marked = YES;
            }
        }
    }
    for (j = 0, i = tree->ntips -2; i >= 0; i--) {
        p = tree->ints[i];
        if (p->llink->marked != NO && p->rlink->marked != NO)
            intNode[j++] = p;
    }
    assert(j == nE -1);
    /* and unmark all nodes */
    for (i = 0; i < tree->ntips; i++)
        tree->tips[i]->marked = NO;
    for (i = 0; i < tree->ntips -1; i++)
        tree->ints[i]->marked = NO;
    
    /* second, sort the intNode array of length nE-1 */
    for (i = 0; i < nE -2; i++) {
        k = i;
        for (j = i +1; j < nE -1; j++)
            if (intNode[j]->age > intNode[k]->age)
                k = j;
        if (k != i) {  // switch i, k
            p = intNode[k];
            intNode[k] = intNode[i];
            intNode[i] = p;
        }
    }
    
    /* third, the first n-1 are sampled, mark the corresponding n extant taxa */
    n = round (rho * nE);  // number of sampled extant taxa
    for (k = 0; k < n -1; k++) {
        brk = NO;
        for (i = 0; i < nE -1; i++) {
            for (j = i +1; j < nE; j++) {
                q = extNode[i];
                while (q != intNode[0]) {
                    q = q->alink;
                    r = extNode[j];
                    while (r != intNode[0] && r != q)
                        r = r->alink;
                    if (r == q)  break;
                }
                if (q == intNode[k]) {  // q is mrca of node_i and node_j
                    extNode[i]->marked = extNode[j]->marked = YES;
                    brk = YES;  break;
                }
            }
            if (brk == YES)  break;
        }
    }
    
    m = 0;  // number of sampled fossils
    if (psi > 0) {
        /* sample fossils on each branch */
        for (i = 0; i < 2 * tree->ntips -2; i++) {
            if (i < tree->ntips)
                s = tree->tips[i];
            else
                s = tree->ints[i - tree->ntips];
            p = s->alink;
            brl = s->brl;
            
            l = suml = rndExp(psi);
            while (suml < brl) {
                if (p->age -l < intNode[n-2]->age)  // do not sample between x_cut and 0
                    break;

                q = newNode();
                r = newNode();
                r->marked = YES;
                m++;
                
                /* relationships and brls */
                if (p->llink == s)
                    p->llink = q;
                else
                    p->rlink = q;
                q->alink = p;
                q->llink = s;
                q->rlink = r;
                r->alink = q;
                s->alink = q;
                sprintf(r->name, "f%d", m);
                q->brl = l;
                r->brl = 0.0;
                q->age = p->age -l;
                r->age = p->age -l;
                s->brl -= l;
                
                /* move on */
                l = rndExp(psi);
                suml += l;
                p = q;
            }
        }
    }
    
    free(intNode);
    free(extNode);
    if (m + n == 0) {
        printf("Warning: nothing sampled!\n");
        return NULL;
    }
    else {
        /* update #tips and node array */
        updateNodeArray(tree);
    }
    // writeTree(stdout, tree);

    /* mark all sampled nodes */
    for (i = 0; i < tree->ntips; i++) {
        p = tree->tips[i];
        if (p->marked == YES) {
            while (p != tree->root) {
                p = p->alink;
                if (p->marked == YES) break;
                else p->marked = YES;
            }
        }
    }
    
    /* extract the sampled tree from the complete tree */
    fbdt = extractFBDTree(tree);
    // writeTree(stdout, fbdt);

    return fbdt;
}

/* d is destination, p is source */
void extractRecursive(pTreeNode d, pTreeNode p) {
    pTreeNode l, r, l_f, r_f;
    double brlen;
    
    if (p == NULL || p->marked == NO) return;
    
    l = p->llink;
    if (l != NULL) {
        brlen = l->brl;
        while (l->llink != NULL && (l->llink->marked == NO || l->rlink->marked == NO)) {
            if (l->llink->marked == NO)
                l = l->rlink;
            else
                l = l->llink;
            brlen += l->brl;
        }
        
        l_f = newNode();
        strcpy(l_f->name, l->name);
        l_f->brl = brlen;
        l_f->age = l->age;
        l_f->alink = d;
        d->llink = l_f;
        
        extractRecursive(l_f, l);
    }
    
    r = p->rlink;
    if (r != NULL) {
        brlen = r->brl;
        while (r->llink != NULL && (r->llink->marked == NO || r->rlink->marked == NO)) {
            if (r->llink->marked == NO)
                r = r->rlink;
            else
                r = r->llink;
            brlen += r->brl;
        }

        r_f = newNode();
        strcpy(r_f->name, r->name);
        r_f->brl = brlen;
        r_f->age = r->age;
        r_f->alink = d;
        d->rlink = r_f;
        
        extractRecursive(r_f, r);
    }
}

/* extract the sampled tree from the full tree with marked nodes */
pPhyTree extractFBDTree(pPhyTree fullTree) {
    pPhyTree fbdTree;
    pTreeNode p;
    
    /* find root of sampled tree */
    p = fullTree->root;
    while (p->llink != NULL && (p->llink->marked == NO || p->rlink->marked == NO)) {
        if (p->llink->marked == NO)
            p = p->rlink;
        else
            p = p->llink;
    }
    
    /* initialize the FBD tree */
    fbdTree = newTree();
    
    /* extract the sampled tree recursively */
    fbdTree->root = newNode();  // start from root
    fbdTree->root->age = fbdTree->height = p->age;
    extractRecursive(fbdTree->root, p);
    
    /* update the tips and ints pointers */
    updateNodeArray(fbdTree);

    return fbdTree;
}

pPhyTree sampleFossilAndExtant(pPhyTree tree, double psi, double rho, char *ss) {
    pPhyTree fbdt = NULL;

    if (strcmp(ss, "rnd") == 0)
        fbdt = sampleFossilAndExtantRnd(tree, psi, rho);
    else if (strcmp(ss, "div") == 0)
        fbdt = sampleFossilAndExtantDiv(tree, psi, rho);
    else
        printf("Error: unrecognized sampling strategy '%s'.\n", ss);

    return fbdt;
}
