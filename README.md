This git repository contains simulation scripts and main outputs under various settings each in a separate folder.  The aim of this simulation study is to explore how well the trees can be inferred from morphological characters. In some simple conditions, the inference model can match the model used to simulate the data, but for the others, the model used in simulation is more complicated than that in inference.

1. Simulating time trees: 
Rooted trees are simulated under a birth-death process with birth rate 5.0 and death rate 4.0, conditioned on root age of 1.0, and kept 100 trees with tips no more than 50. 
The simulation script is “bd.sim.r” in the “simulator” folder, and it requires R and the TreeSim package in R. The output trees are saved in “bd.trees”. Tree height, tree length, number of extant tips and number of extinct tips (treated as fossils) are summarized in “bd.tl.txt”. 

2. Simulating morphological characters: 
Given each tree, 200 morphological binary characters are simulated under the given substitution and clock models. 
The source code of this simulator is in the “simulator/src” folder.  Usage can be found in “readme.txt” in the “simulator” folder.

3. Inferring undated trees: 
The trees inferred from morphological characters are unrooted. Branch lengths in the tree are measured by distance. The commands for MrBayes are in “mb_un_*.nex” in the “scripts” folder.  The master script to run all analyses is “master.sh”.

4. Inferring time trees: 
The trees inferred using tip dating approach are rooted. The data include morphological characters and tip (fossil) ages. The tree prior is given by the fossilized birth-death process. The prior for the rates is independent lognormal. The clock rates are shared (linked) by all characters. 

5. Summarizing results: 
The tree distance metrics are summarized using "sum_t.r".

---
Prerequirement: Linux (or WSL). Install gcc and R in Linux. 

To start, create a folder, e.g. called “test”. 

1. Run `bd.sim.r` in R to generate trees. Copy a small tree (e.g., line 19) in “bd.trees” and save it to “bd.tre” in the “test” folder.
  
2. Compile the source code in “simulator/src” and put the generated executable “msim” in the “test” folder. 

3. Compile the source code of MrBayes (downloaded from the develop branch on GitHub) and put the generated executable “mb” in the “test” folder. 

4. Copy “mb_un_m2v.nex” in the “scripts” folder to the “test” folder as "cmd.nex". 
Now the “test” folder contains: `bd.tre, cmd.nex, msim, mb`. In the Linux terminal, use the `cd` command to navigate to the “test” folder.

5. Run `./msim -i bd.tre -o data.nex -l 200 > run.log`. This will generate a file called “data.nex” containing a morphological character matrix.

6. Run `./mb cmd.nex >> run.log`. This will infer a tree from the data and save it to “data.nex.con.tre”.

7. Compare the true tree (bd.tre) with the inferred tree (data.nex.con.tre), e.g., using FigTree.

Once finishing this test, you can start to understand the script “run.sh”. You can also write your own script to automate the analysis.
