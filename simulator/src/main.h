#ifndef _MAIN_H_
#define _MAIN_H_

#include "tree.h"
#include "rate.h"
#include "utils.h"
#include "seqs.h"

void writeMBCmd_FixTree(FILE *fp, pPhyTree tree);
void writeMBCmd_Data(FILE *fp, pPhyTree tree);

#endif
