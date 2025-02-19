#include "tree.h"
#include "utils.h"

/* NEXUS file for MrBayes */
void writeMrBayesCmd(FILE* fp, pPhyTree tree, double missing) {
    int i, j;

    fprintf(fp, "#NEXUS\n");
    fprintf(fp, "Begin data;\n");
    if (tree->nsites > 0)
        fprintf(fp, "  dimensions ntax=%d nchar=%d;\n", tree->ntips, tree->nsites);
    else
        fprintf(fp, "  dimensions ntax=%d nchar=1;\n", tree->ntips);

    fprintf(fp, "  format datatype=standard gap=- missing=?;\n");
    fprintf(fp, "matrix\n");
    if (tree->nsites > 0) {
        for (i = 0; i < tree->ntips; i++) {
            fprintf(fp, "  %s\t", tree->tips[i]->name);
            for (j = 0; j < tree->nsites; j++) {
                if (rndu() < missing && tree->tips[i]->age > 1E-8)
                    fprintf(fp, "?");
                else
                    fprintf(fp, "%d", tree->tips[i]->sequence[j]);
            }
            fprintf(fp, "\n");
        }
    } else {
        for (i = 0; i < tree->ntips; i++) {
            fprintf(fp, "  %s\t?\n", tree->tips[i]->name);
        }
    }
    fprintf(fp, ";\nEnd;\n\n");
    
    fprintf(fp, "Begin trees;\n");
    fprintf(fp, "  tree mytree=[&R][&clockrate = %lf]", tree->rbase);
    writeRootedTree(fp, tree->root);
    fprintf(fp, ";\nEnd;\n\n");
    
    fprintf(fp, "Begin MrBayes;\n");
    for (i = 0; i < tree->ntips; i++) {
        if (tree->tips[i]->age > 1E-8) {
            fprintf(fp, "  calibrate %s=fixed(%.10lf);\n", tree->tips[i]->name, tree->tips[i]->age);
        }
    }
    fprintf(fp, "  prset nodeagepr=calibrated;\n");
    fprintf(fp, "End;\n");
}
