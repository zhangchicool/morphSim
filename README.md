This git repository contains simulation scripts and main outputs under various settings each in a separate folder.  The aim of this simulation study is to explore how well the trees can be inferred from morphological characters. In some simple conditions, the inference model can match the model used to simulate the data, but for the others, the model used in simulation is more complicated than that in inference.

1. Simulating rooted trees
Rooted trees are simulated under a birth-death process with birth rate 5.0 and death rate 4.0, conditioned on root age of 1.0, and kept 100 trees with tips no more than 50. 
The simulation script is “bd.sim.r” in the “simulator” folder, and it requires R and the TreeSim package in R. The output trees are saved in “bd.trees”. Tree height, tree length, number of extant tips and number of extinct tips (treated as fossils) are summarized in “bd.tl.txt”. 

2. Simulating morphological characters
Given each tree, 200 morphological characters (binary to up to 4-state with proportions of 0.5, 0.3, 0.2) are simulated under the given substitution and clock models. 
The source code of this simulator is in the “simulator/src” folder.  Usage can be found in “readme.txt” in the “simulator” folder.

2.1. Mkv and strict clock. All characters have equal and constant clock rate.

2.2. Mkv and relaxed clock. The mean rate is the same across characters, but each character has its own clock rate variation. The relative clock rate on each branch follows the same lognormal distribution with mean 1.0 and variance as the specified value.

2.3. Fkv and strict clock. The state frequencies for each character are drawn from a symmetric Dirichlet distribution (with concentration parameter a). Small a (<1) prefers sparse variates so that the character states are heterogeneous, while big a (>1) prefers evenly distributed variates. When a is infinity, Fkv becomes Mkv where the states have equal frequencies (Wright et al. 2016). 

2.4. Fkv and relaxed clock.

3. Inferring undated trees
The trees inferred from morphological characters are unrooted. Branch lengths in the tree are measured by distance. The commands for MrBayes are in “cmd.nex”, in each “xx-vs-xx” folder in the “nonclock” folder.  The master script to run 100 replicates under each setting is “run.sh”.

4. Inferring time trees 
The trees inferred using tip dating approach are rooted. The data include morphological characters and tip (fossil) ages. The tree prior is given by the fossilized birth-death process. The prior for the rates is independent lognormal. The clock rates are shared (linked) by all characters. 

5. Summarizing results
Files are in the “processing” folder. TODO: organize and cleanup



Prerequirement: Linux (or WSL). Install gcc and R in Linux. 

To start, create a folder, e.g. called “test”. 

1. Run “bd.sim.r” in R to generate trees. Copy a small tree (e.g., line 19) in “bd.trees” and save it to “bd.tre” in the “test” folder.
  
2. Compile the source code in “simulator/src” and put the generated executable “fbdt” in the “test” folder. 

3. Compile the source code of MrBayes (downloaded from the develop branch on GitHub) and put the generated executable “mb” in the “test” folder. 

4. Copy “cmd.nex” in the “nonclock/mkv-vs-mkv” folder to the “test” folder. 
Now the “test” folder contains: “bd.tre, cmd.nex, fbdt, mb”. In the Linux terminal, use the “cd” command to navigate to the “test” folder.

5. Run “./fbdt -i bd.tre -o data.nex -l 200 >> run.log”. This will generate a file called “data.nex” containing a morphological character matrix.

6. Run “./mb cmd.nex >> run.log”. This will infer a tree from the data and be saved in “data.nex.con.tre”.

7. Compare the true tree with the inferred tree, e.g., using FigTree.

Once finishing this test, you can start to understand the script “run.sh”. You can also write your own script to automate the analysis.
