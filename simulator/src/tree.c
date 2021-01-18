#include "tree.h"

int getChar(FILE *fp) {
    /* get a non-space char from file */
    int c;
    do { c = fgetc(fp);
    } while (isspace(c));
    return c;
}

pTreeNode newNode() {
	pTreeNode p = (pTreeNode)malloc(sizeof(struct TreeNode));
	if (p == NULL) {
		printf("Failed to allocate tree node.\n");
        exit(1);
	}
	p->llink = p->rlink = p->alink = NULL;
	p->brlen = p->age = 0.0;
    p->rate = 1.0;
    p->sequence = NULL;
	return p;
}

pTreeNode readNode(FILE *fp, pTreeNode p, int side) {
    int i, c;
    pTreeNode q = newNode();
    
    if (side == LEFT) {
        p->llink = q;
        q->alink = p;
    }
    else if (side == RIGHT) {
        p->rlink = q;
        q->alink = p;
    }
    else { // side == ANCES
        q->rlink = p;
        p->alink = q;
    }
    
    /* read in branch length and node name */
    c = getChar(fp);
    if (c == '(') {
        if (side == ANCES)
            readUnrootedTree(fp, q);
        else
            readRootedTree(fp, q);
        c = getChar(fp);
        if (c == ':') {
            if (side == ANCES)
                fscanf(fp, "%lf", &p->brlen);
            else
                fscanf(fp, "%lf", &q->brlen);
        }
        else
            ungetc(c, fp);
    }
    else {
        for (i = 0; i < MaxNameLen; i++) {
            if (c == ',') {
                ungetc(c, fp);
                break;
            }
            else if (c == ':') {
                if (side == ANCES)
                    fscanf(fp, "%lf", &p->brlen);
                else
                    fscanf(fp, "%lf", &q->brlen);
                break;
            }
            q->name[i] = c;
            c = fgetc(fp);
        }
        q->name[i] = '\0';
    }
    
    /* ignore attributes for now */
    c = getChar(fp);
    if (c == '[') {
        do {
            c = fgetc(fp);
        } while (c != ']' && c != EOF);
    }
    else
        ungetc(c, fp);
    
    return q;
}

void readRootedTree(FILE *fp, pTreeNode p) {
    int c;
    
    /* recursively read the left element (L,) */
    readNode(fp, p, LEFT);
    
    /* the middle character of a pair must be ',' */
    c = getChar(fp);
    if (c != ',') {
        printf("Error: expecting ',', got '%c' instead.\n", c);
        exit(1);
    }
    
    /* recursively read the right element (,R) */
    readNode(fp, p, RIGHT);
    
    /* the last character of a pair must be ')' */
    c = getChar(fp);
    if (c != ')') {
        printf("Error: expecting ')', got '%c' instead.\n", c);
        exit(1);
    }
}

void readUnrootedTree(FILE *fp, pTreeNode p) {
    int c;
    
    /* p is center of tri-partition (A,L,R)
       recursively read the anc element (A,,) */
    readNode(fp, p, ANCES);
    
    /* the end character of ancestral part must be ',' */
    c = getChar(fp);
    if (c != ',') {
        printf("Error: expecting ',', got '%c' instead.\n", c);
        exit(1);
    }
    
    /* treat the left part (,L,) as rooted tree */
    readNode(fp, p, LEFT);
    
    if (p->rlink == NULL) {
        /* the end character of left part must be ',' */
        c = getChar(fp);
        if (c != ',') {
            printf("Error: expecting ',', got '%c' instead.\n", c);
            exit(1);
        }
        
        /* treat the right part (,,R) as rooted tree */
        readNode(fp, p, RIGHT);
    }
    
    /* the last character must be ')' */
    c = getChar(fp);
    if (c != ')') {
        printf("Error: expecting ')', got '%c' instead.\n", c);
        exit(1);
    }
}

void getNumTips(pPhyTree tree, pTreeNode p) {
    /* get number of tips, for either rooted or unrooted tree */
    if (p == NULL) return;
    if (p->llink != NULL) {
        getNumTips(tree, p->llink);
    }
    else
        (tree->ntips)++;
    if (p->rlink != NULL) {
        getNumTips(tree, p->rlink);
    }
}

void getAllNodes(pPhyTree tree, pTreeNode p, int *i, int *j) {
    if (p == NULL) return;
    
    getAllNodes(tree, p->llink, i, j);
    getAllNodes(tree, p->rlink, i, j);
    
    if (p->llink == NULL) {  // tip
        tree->tips[(*j)++] = p;
    }
    else {  // internal node
        tree->ints[(*i)++] = p;
        sprintf(p->name, "i%d", (*i) + tree->ntips);
    }
}

void getTreeLength(pPhyTree tree) {
    int i;
    
    tree->length = 0.0;
    for (i = 0; i < tree->ntips; i++)
        tree->length += tree->tips[i]->brlen;
    for (i = 0; i < tree->ntips -2; i++)
        tree->length += tree->ints[i]->brlen;
}

void getNodeAges(pPhyTree tree) {
    int i;
    double h;
    pTreeNode p;
    
    if (tree->type == UNROOT) {
        printf("getNodeAges: not for unrooted tree.\n");
        return;
    }
    
    /* get tree height */
    tree->height = 0.0;
    for (i = 0; i < tree->ntips; i++) {
        h = 0.0;
        p = tree->tips[i];
        while (p != tree->root) {
            h += p->brlen;
            p = p->alink;
        }
        if (tree->height < h)
            tree->height = h;
    }
    
    /* get node ages */
    for (i = 0; i < tree->ntips; i++) {
        h = 0.0;
        p = tree->tips[i];
        while (p != tree->root) {
            h += p->brlen;
            p = p->alink;
        }
        /* get tip time */
        if (fabs(tree->height - h) < 1E-8)
            tree->tips[i]->age = 0.0;
        else
            tree->tips[i]->age = tree->height - h;
    }
    for (i = 0; i < tree->ntips -1; i++) {
        h = 0.0;
        p = tree->ints[i];
        while (p != tree->root) {
            h += p->brlen;
            p = p->alink;
        }
        /* get int time */
        tree->ints[i]->age = tree->height - h;
    }
}

pPhyTree readTree(FILE *fp, int type) {
    pPhyTree TREE = NULL;
    int c,  i, j;
    
    /* the first character of a tree must be '(' */
    do { c = fgetc(fp);
    } while (c != '(' && c != EOF);
    if (c == EOF) {
        printf("No tree found in file.\n");
        exit(1);
    }
    
    /* initialize the tree */
    TREE = (pPhyTree)malloc(sizeof(struct PhyTree));
    if (TREE == NULL) {
        printf("Failed to initialize TREE.\n");
        exit(1);
    }
    TREE->root = newNode();
    
    /* read tree from file */
    if (type == ROOTED) {
        TREE->type = ROOTED;
        readRootedTree(fp, TREE->root);
    }
    else if (type == UNROOT) {
        TREE->type = UNROOT;
        readUnrootedTree(fp, TREE->root);
        /* the first taxa is treated as root */
        while (TREE->root->alink != NULL) {
            TREE->root = TREE->root->alink;
        }
    }
    c = getChar(fp);
    if (c != ';') {
        printf("Warning: expecting ';' at the end, got '%c' instead.\n", c);
    }
    
    /* get other info, must call functions in order */
    TREE->ntips = 0; // reset
    getNumTips(TREE, TREE->root);
    TREE->tips = (pTreeNode *)malloc(TREE->ntips * sizeof(pTreeNode));
    TREE->ints = (pTreeNode *)malloc(TREE->ntips * sizeof(pTreeNode));
    if (TREE->tips == NULL || TREE->ints == NULL) {
        printf("Failed to allocate node array.\n");
        exit(1);
    }
    i = j = 0;
    getAllNodes(TREE, TREE->root, &i, &j);
    getTreeLength(TREE);
    if (type == ROOTED) {
        getNodeAges(TREE);
    }
    
    return TREE;
}

void writeRootedTree(FILE *fp, pTreeNode p, pTreeNode root) {
    if (p == NULL) return;
    if (p->llink != NULL)  // && p->rlink != NULL
        fprintf(fp, "(");
    else
        fprintf(fp, "%s:%lf", p->name, p->brlen);
    writeRootedTree(fp, p->llink, root);
    if (p->llink != NULL)  // && p->rlink != NULL
        fprintf(fp, ",");
    writeRootedTree(fp, p->rlink, root);
    if (p == root)
        fprintf(fp, ")");
    else if (p->llink != NULL)
        fprintf(fp, "):%lf", p->brlen);
}

void writeUnrootedTree(FILE *fp, pTreeNode p) {
    pTreeNode q;
    
    if (p == NULL) return;
    q = p->rlink;
    if (q == NULL || q->llink == NULL || q->rlink == NULL) return;
    fprintf(fp, "(%s:%lf,", p->name, q->brlen);
    
    if (q->llink->llink == NULL)
        fprintf(fp, "%s:%lf,", q->llink->name, q->llink->brlen);
    else{
        writeRootedTree(fp, q->llink, q->llink);
        fprintf(fp, ":%lf,", q->llink->brlen);
    }
    
    if (q->rlink->rlink == NULL)
        fprintf(fp, "%s:%lf)", q->rlink->name, q->rlink->brlen);
    else{
        writeRootedTree(fp, q->rlink, q->rlink);
        fprintf(fp, ":%lf)", q->rlink->brlen);
    }
}

void writeTree(FILE *fp, pPhyTree tree) {
    if (tree == NULL) return;
    if (tree->type == ROOTED) {
        writeRootedTree(fp, tree->root, tree->root);
        fprintf(fp, ";\n");
    }
    else {  // tree->type == UNROOT
        writeUnrootedTree(fp, tree->root);
        fprintf(fp, ";\n");
    }
}

void freeT(pTreeNode p) {
	if (p == NULL) return;
	freeT(p->llink);
	freeT(p->rlink);
    free (p->sequence);
	free (p);
}
void freeTree(pPhyTree tree) {
	if (tree == NULL) return;
	freeT(tree->root);
    free (tree->ints);
    free (tree->tips);
	free (tree);
}
