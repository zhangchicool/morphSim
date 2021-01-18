#ifndef _TREE_H_
#define _TREE_H_

#include <ctype.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

#define MaxNameLen 99

#define UNROOT 0
#define ROOTED 1

#define LEFT   1
#define RIGHT  2
#define ANCES  3

struct TreeNode;
typedef struct TreeNode *pTreeNode;
struct TreeNode {
    char   name[MaxNameLen+1];
	double brlen;
    double age;
    double rate;
    int   *sequence;
    pTreeNode llink, rlink, alink;
};

struct PhyTree {
    pTreeNode root, *tips, *ints;
    double length, height, baserate;
    int type, ntips, nsites;
};
typedef struct PhyTree *pPhyTree;

/* functions */
pTreeNode newNode(void);

void readRootedTree(FILE *fp, pTreeNode p);
void readUnrootedTree(FILE *fp, pTreeNode p);
pPhyTree readTree(FILE *fp, int type);

void writeTree(FILE* fp, pPhyTree tree);
void freeTree(pPhyTree tree);

#endif
