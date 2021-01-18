#ifndef _RATE_H_
#define _RATE_H_

#define STRICT 0
#define IGR    1
#define ILN    2
#define NORM   3

void simulateRates(pPhyTree tree, int clock, double var);
void writeRootedTreeRates(FILE* fp, pTreeNode p, pTreeNode root, double brate);

#endif
