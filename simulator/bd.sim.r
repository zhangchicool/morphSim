library("TreeSim")

rept  <- 100  # replicates
tmrca <- 1.0
birth <- 5.0
death <- 4.0

tree  <- sim.bd.age(tmrca, rept, birth, death, mrca=T)

for(i in 1:rept) {
	# plot.phylo(tree[[i]])
	write.tree(tree[[i]], file="bd.trees", append=T)
}

# replace ending ':0;' with ';'
# sed -i 's/:0;/;/g' bd.trees      
