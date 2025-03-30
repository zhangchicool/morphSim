library(vioplot)

setwd("~/Documents/Research/2024-MorphSim/")

true  <- read.table("simulator/bd.tl.txt", header=T)

## tree lengths (full) ##
tl_1  <- read.table("nonclock/m2v-vs-m2v/tl_estm.txt",     header=F)
tl_2  <- read.table("nonclock/m2v-vs-f2v/tl_estm.txt",     header=F)
tl_3  <- read.table("nonclock/f2v-a1-vs-m2v/tl_estm.txt",  header=F)
tl_4  <- read.table("nonclock/f2v-a1-vs-f2v/tl_estm.txt",  header=F)
tl_5  <- read.table("nonclock/f2v-v4-vs-m2v/tl_estm.txt",  header=F)
tl_6  <- read.table("nonclock/f2v-v4-vs-f2vg/tl_estm.txt", header=F)
tl_7  <- read.table("nonclock/g4v-a10-vs-m2v/tl_estm.txt", header=F)
tl_8  <- read.table("nonclock/g4v-a10-vs-f2v/tl_estm.txt", header=F)
tl_9  <- read.table("nonclock/g4v-a1-vs-m2v/tl_estm.txt",  header=F)
tl_10 <- read.table("nonclock/g4v-a1-vs-f2v/tl_estm.txt",  header=F)
tl_11 <- read.table("nonclock/g4v-v4-vs-m2v/tl_estm.txt",  header=F)
tl_12 <- read.table("nonclock/g4v-v4-vs-f2vg/tl_estm.txt", header=F)
tl_13 <- read.table("nonclock/g8v-a10-vs-m2v/tl_estm.txt", header=F)
tl_14 <- read.table("nonclock/g8v-a10-vs-f2v/tl_estm.txt", header=F)
tl_15 <- read.table("nonclock/g8v-a1-vs-m2v/tl_estm.txt",  header=F)
tl_16 <- read.table("nonclock/g8v-a1-vs-f2v/tl_estm.txt",  header=F)
tl_17 <- read.table("nonclock/g8v-v4-vs-m2v/tl_estm.txt",  header=F)
tl_18 <- read.table("nonclock/g8v-v4-vs-f2vg/tl_estm.txt", header=F)
## tree heights (full) ##
th_1  <- read.table("tipdating/m2v-vs-m2v/th_estm.txt",     header=F)
th_2  <- read.table("tipdating/m2v-vs-f2v/th_estm.txt",     header=F)
th_3  <- read.table("tipdating/f2v-a1-vs-m2v/th_estm.txt",  header=F)
th_4  <- read.table("tipdating/f2v-a1-vs-f2v/th_estm.txt",  header=F)
th_5  <- read.table("tipdating/f2v-v4-vs-m2v/th_estm.txt",  header=F)
th_6  <- read.table("tipdating/f2v-v4-vs-f2vg/th_estm.txt", header=F)
th_7  <- read.table("tipdating/g4v-a10-vs-m2v/th_estm.txt", header=F)
th_8  <- read.table("tipdating/g4v-a10-vs-f2v/th_estm.txt", header=F)
th_9  <- read.table("tipdating/g4v-a1-vs-m2v/th_estm.txt",  header=F)
th_10 <- read.table("tipdating/g4v-a1-vs-f2v/th_estm.txt",  header=F)
th_11 <- read.table("tipdating/g4v-v4-vs-m2v/th_estm.txt",  header=F)
th_12 <- read.table("tipdating/g4v-v4-vs-f2vg/th_estm.txt", header=F)
th_13 <- read.table("tipdating/g8v-a10-vs-m2v/th_estm.txt", header=F)
th_14 <- read.table("tipdating/g8v-a10-vs-f2v/th_estm.txt", header=F)
th_15 <- read.table("tipdating/g8v-a1-vs-m2v/th_estm.txt",  header=F)
th_16 <- read.table("tipdating/g8v-a1-vs-f2v/th_estm.txt",  header=F)
th_17 <- read.table("tipdating/g8v-v4-vs-m2v/th_estm.txt",  header=F)
th_18 <- read.table("tipdating/g8v-v4-vs-f2vg/th_estm.txt", header=F)

## tree lengths (missing) ##
tl_1  <- read.table("nonclock-mis/m2v-vs-m2v/tl_estm.txt",     header=F)
tl_2  <- read.table("nonclock-mis/m2v-vs-f2v/tl_estm.txt",     header=F)
tl_3  <- read.table("nonclock-mis/f2v-a1-vs-m2v/tl_estm.txt",  header=F)
tl_4  <- read.table("nonclock-mis/f2v-a1-vs-f2v/tl_estm.txt",  header=F)
tl_5  <- read.table("nonclock-mis/f2v-v4-vs-m2v/tl_estm.txt",  header=F)
tl_6  <- read.table("nonclock-mis/f2v-v4-vs-f2vg/tl_estm.txt", header=F)
tl_7  <- read.table("nonclock-mis/g4v-a10-vs-m2v/tl_estm.txt", header=F)
tl_8  <- read.table("nonclock-mis/g4v-a10-vs-f2v/tl_estm.txt", header=F)
tl_9  <- read.table("nonclock-mis/g4v-a1-vs-m2v/tl_estm.txt",  header=F)
tl_10 <- read.table("nonclock-mis/g4v-a1-vs-f2v/tl_estm.txt",  header=F)
tl_11 <- read.table("nonclock-mis/g4v-v4-vs-m2v/tl_estm.txt",  header=F)
tl_12 <- read.table("nonclock-mis/g4v-v4-vs-f2vg/tl_estm.txt", header=F)
tl_13 <- read.table("nonclock-mis/g8v-a10-vs-m2v/tl_estm.txt", header=F)
tl_14 <- read.table("nonclock-mis/g8v-a10-vs-f2v/tl_estm.txt", header=F)
tl_15 <- read.table("nonclock-mis/g8v-a1-vs-m2v/tl_estm.txt",  header=F)
tl_16 <- read.table("nonclock-mis/g8v-a1-vs-f2v/tl_estm.txt",  header=F)
tl_17 <- read.table("nonclock-mis/g8v-v4-vs-m2v/tl_estm.txt",  header=F)
tl_18 <- read.table("nonclock-mis/g8v-v4-vs-f2vg/tl_estm.txt", header=F)
## tree heights (missing) ##
th_1  <- read.table("tipdating-mis/m2v-vs-m2v/th_estm.txt",     header=F)
th_2  <- read.table("tipdating-mis/m2v-vs-f2v/th_estm.txt",     header=F)
th_3  <- read.table("tipdating-mis/f2v-a1-vs-m2v/th_estm.txt",  header=F)
th_4  <- read.table("tipdating-mis/f2v-a1-vs-f2v/th_estm.txt",  header=F)
th_5  <- read.table("tipdating-mis/f2v-v4-vs-m2v/th_estm.txt",  header=F)
th_6  <- read.table("tipdating-mis/f2v-v4-vs-f2vg/th_estm.txt", header=F)
th_7  <- read.table("tipdating-mis/g4v-a10-vs-m2v/th_estm.txt", header=F)
th_8  <- read.table("tipdating-mis/g4v-a10-vs-f2v/th_estm.txt", header=F)
th_9  <- read.table("tipdating-mis/g4v-a1-vs-m2v/th_estm.txt",  header=F)
th_10 <- read.table("tipdating-mis/g4v-a1-vs-f2v/th_estm.txt",  header=F)
th_11 <- read.table("tipdating-mis/g4v-v4-vs-m2v/th_estm.txt",  header=F)
th_12 <- read.table("tipdating-mis/g4v-v4-vs-f2vg/th_estm.txt", header=F)
th_13 <- read.table("tipdating-mis/g8v-a10-vs-m2v/th_estm.txt", header=F)
th_14 <- read.table("tipdating-mis/g8v-a10-vs-f2v/th_estm.txt", header=F)
th_15 <- read.table("tipdating-mis/g8v-a1-vs-m2v/th_estm.txt",  header=F)
th_16 <- read.table("tipdating-mis/g8v-a1-vs-f2v/th_estm.txt",  header=F)
th_17 <- read.table("tipdating-mis/g8v-v4-vs-m2v/th_estm.txt",  header=F)
th_18 <- read.table("tipdating-mis/g8v-v4-vs-f2vg/th_estm.txt", header=F)

# relative bias
tl_bias1  <- (tl_1$V2 - true$tLength) / true$tLength
tl_bias2  <- (tl_2$V2 - true$tLength) / true$tLength
tl_bias3  <- (tl_3$V2 - true$tLength) / true$tLength
tl_bias4  <- (tl_4$V2 - true$tLength) / true$tLength
tl_bias5  <- (tl_5$V2 - true$tLength) / true$tLength
tl_bias6  <- (tl_6$V2 - true$tLength) / true$tLength
tl_bias7  <- (tl_7$V2 - true$tLength) / true$tLength
tl_bias8  <- (tl_8$V2 - true$tLength) / true$tLength
tl_bias9  <- (tl_9$V2 - true$tLength) / true$tLength
tl_bias10 <- (tl_10$V2- true$tLength) / true$tLength
tl_bias11 <- (tl_11$V2- true$tLength) / true$tLength
tl_bias12 <- (tl_12$V2- true$tLength) / true$tLength
tl_bias13 <- (tl_13$V2- true$tLength) / true$tLength
tl_bias14 <- (tl_14$V2- true$tLength) / true$tLength
tl_bias15 <- (tl_15$V2- true$tLength) / true$tLength
tl_bias16 <- (tl_16$V2- true$tLength) / true$tLength
tl_bias17 <- (tl_17$V2- true$tLength) / true$tLength
tl_bias18 <- (tl_18$V2- true$tLength) / true$tLength

th_bias1  <- (th_1$V2 - true$tHeight) / true$tHeight
th_bias2  <- (th_2$V2 - true$tHeight) / true$tHeight
th_bias3  <- (th_3$V2 - true$tHeight) / true$tHeight
th_bias4  <- (th_4$V2 - true$tHeight) / true$tHeight
th_bias5  <- (th_5$V2 - true$tHeight) / true$tHeight
th_bias6  <- (th_6$V2 - true$tHeight) / true$tHeight
th_bias7  <- (th_7$V2 - true$tHeight) / true$tHeight
th_bias8  <- (th_8$V2 - true$tHeight) / true$tHeight
th_bias9  <- (th_9$V2 - true$tHeight) / true$tHeight
th_bias10 <- (th_10$V2- true$tHeight) / true$tHeight
th_bias11 <- (th_11$V2- true$tHeight) / true$tHeight
th_bias12 <- (th_12$V2- true$tHeight) / true$tHeight
th_bias13 <- (th_13$V2- true$tHeight) / true$tHeight
th_bias14 <- (th_14$V2- true$tHeight) / true$tHeight
th_bias15 <- (th_15$V2- true$tHeight) / true$tHeight
th_bias16 <- (th_16$V2- true$tHeight) / true$tHeight
th_bias17 <- (th_17$V2- true$tHeight) / true$tHeight
th_bias18 <- (th_18$V2- true$tHeight) / true$tHeight

# relative CI width
tl_CIw1  <- (tl_1$V5 - tl_1$V4) / true$tLength
tl_CIw2  <- (tl_2$V5 - tl_2$V4) / true$tLength
tl_CIw3  <- (tl_3$V5 - tl_3$V4) / true$tLength
tl_CIw4  <- (tl_4$V5 - tl_4$V4) / true$tLength
tl_CIw5  <- (tl_5$V5 - tl_5$V4) / true$tLength
tl_CIw6  <- (tl_6$V5 - tl_6$V4) / true$tLength
tl_CIw7  <- (tl_7$V5 - tl_7$V4) / true$tLength
tl_CIw8  <- (tl_8$V5 - tl_8$V4) / true$tLength
tl_CIw9  <- (tl_9$V5 - tl_9$V4) / true$tLength
tl_CIw10 <- (tl_10$V5- tl_10$V4)/ true$tLength
tl_CIw11 <- (tl_11$V5- tl_11$V4)/ true$tLength
tl_CIw12 <- (tl_12$V5- tl_12$V4)/ true$tLength
tl_CIw13 <- (tl_13$V5- tl_13$V4)/ true$tLength
tl_CIw14 <- (tl_14$V5- tl_14$V4)/ true$tLength
tl_CIw15 <- (tl_15$V5- tl_15$V4)/ true$tLength
tl_CIw16 <- (tl_16$V5- tl_16$V4)/ true$tLength
tl_CIw17 <- (tl_17$V5- tl_17$V4)/ true$tLength
tl_CIw18 <- (tl_18$V5- tl_18$V4)/ true$tLength

th_CIw1  <- (th_1$V5 - th_1$V4) / true$tHeight
th_CIw2  <- (th_2$V5 - th_2$V4) / true$tHeight
th_CIw3  <- (th_3$V5 - th_3$V4) / true$tHeight
th_CIw4  <- (th_4$V5 - th_4$V4) / true$tHeight
th_CIw5  <- (th_5$V5 - th_5$V4) / true$tHeight
th_CIw6  <- (th_6$V5 - th_6$V4) / true$tHeight
th_CIw7  <- (th_7$V5 - th_7$V4) / true$tHeight
th_CIw8  <- (th_8$V5 - th_8$V4) / true$tHeight
th_CIw9  <- (th_9$V5 - th_9$V4) / true$tHeight
th_CIw10 <- (th_10$V5- th_10$V4)/ true$tHeight
th_CIw11 <- (th_11$V5- th_11$V4)/ true$tHeight
th_CIw12 <- (th_12$V5- th_12$V4)/ true$tHeight
th_CIw13 <- (th_13$V5- th_13$V4)/ true$tHeight
th_CIw14 <- (th_14$V5- th_14$V4)/ true$tHeight
th_CIw15 <- (th_15$V5- th_15$V4)/ true$tHeight
th_CIw16 <- (th_16$V5- th_16$V4)/ true$tHeight
th_CIw17 <- (th_17$V5- th_17$V4)/ true$tHeight
th_CIw18 <- (th_18$V5- th_18$V4)/ true$tHeight

# plot tree lengths and heights
par(mfrow=c(4,2), mar=c(2.5,4.5,2.5,0.5))

vioplot(tl_bias1, tl_bias2, tl_bias7, tl_bias8, tl_bias13,tl_bias14,
        tl_bias3, tl_bias4, tl_bias9, tl_bias10,tl_bias15,tl_bias16,
        tl_bias5, tl_bias6, tl_bias11,tl_bias12,tl_bias17,tl_bias18,
        xaxt="n", ylim=c(-1,0.4))
axis(side=1, at=1:18, labels=1:18)
title(main="tree length (nonclock)", ylab="relative bias")
legend("topright", "full", bty="n")

vioplot(th_bias1, th_bias2, th_bias7, th_bias8, th_bias13,th_bias14,
        th_bias3, th_bias4, th_bias9, th_bias10,th_bias15,th_bias16,
        th_bias5, th_bias6, th_bias11,th_bias12,th_bias17,th_bias18,
        xaxt="n", ylim=c(-0.6,0.2))
axis(side=1, at=1:18, labels=1:18)
title(main="tree height (tip-dating)")
legend("bottomright", "full", bty="n")

vioplot(tl_CIw1, tl_CIw2, tl_CIw7, tl_CIw8, tl_CIw13,tl_CIw14,
        tl_CIw3, tl_CIw4, tl_CIw9, tl_CIw10,tl_CIw15,tl_CIw16,
        tl_CIw5, tl_CIw6, tl_CIw11,tl_CIw12,tl_CIw17,tl_CIw18,
        xaxt="n", ylim=c(0,1.2))
axis(side=1, at=1:18, labels=1:18)
title(ylab="relative CI width")
legend("topright", "full", bty="n")

vioplot(th_CIw1, th_CIw2, th_CIw7, th_CIw8, th_CIw13,th_CIw14,
        th_CIw3, th_CIw4, th_CIw9, th_CIw10,th_CIw15,th_CIw16,
        th_CIw5, th_CIw6, th_CIw11,th_CIw12,th_CIw17,th_CIw18,
        xaxt="n", ylim=c(0,1))
axis(side=1, at=1:18, labels=1:18)
legend("topright", "full", bty="n")

# missing
vioplot(tl_bias1, tl_bias2, tl_bias7, tl_bias8, tl_bias13,tl_bias14,
        tl_bias3, tl_bias4, tl_bias9, tl_bias10,tl_bias15,tl_bias16,
        tl_bias5, tl_bias6, tl_bias11,tl_bias12,tl_bias17,tl_bias18,
        xaxt="n", ylim=c(-1,0.4))
axis(side=1, at=1:18, labels=1:18)
title(ylab="relative bias")
legend("topright", "missing", bty="n")

vioplot(th_bias1, th_bias2, th_bias7, th_bias8, th_bias13,th_bias14,
        th_bias3, th_bias4, th_bias9, th_bias10,th_bias15,th_bias16,
        th_bias5, th_bias6, th_bias11,th_bias12,th_bias17,th_bias18,
        xaxt="n", ylim=c(-0.6,0.2))
axis(side=1, at=1:18, labels=1:18)
legend("bottomright", "missing", bty="n")

vioplot(tl_CIw1, tl_CIw2, tl_CIw7, tl_CIw8, tl_CIw13,tl_CIw14,
        tl_CIw3, tl_CIw4, tl_CIw9, tl_CIw10,tl_CIw15,tl_CIw16,
        tl_CIw5, tl_CIw6, tl_CIw11,tl_CIw12,tl_CIw17,tl_CIw18,
        xaxt="n", ylim=c(0,1.2))
axis(side=1, at=1:18, labels=1:18)
title(ylab="relative CI width")
legend("topright", "missing", bty="n")

vioplot(th_CIw1, th_CIw2, th_CIw7, th_CIw8, th_CIw13,th_CIw14,
        th_CIw3, th_CIw4, th_CIw9, th_CIw10,th_CIw15,th_CIw16,
        th_CIw5, th_CIw6, th_CIw11,th_CIw12,th_CIw17,th_CIw18,
        xaxt="n", ylim=c(0,1))
axis(side=1, at=1:18, labels=1:18)
legend("topright", "missing", bty="n")

# legend("topleft", 
#        c(" 1: M2v-vs-M2v;        2: M2v-vs-F2v",
#          " 3: G4v-a10-vs-M2v;    4: G4v-a10-vs-F2v",
#          " 5: G8v-a10-vs-M2v;    6: G8v-a10-vs-F2v",
#          " 7: F2v-vs-M2v;        8: F2v-vs-F2v",
#          " 9: G4v-a1-vs-M2v;    10: G4v-a1-vs-F2v",
#          "11: G8v-a1-vs-M2v;    12: G8v-a1-vs-F2v",
#          "13: F2v-v4-vs-M2v;    14: F2v-v4-vs-F2vG",
#          "15: G4v-a1-v4-vs-M2v; 16: G4v-a1-v4-vs-F2vG",
#          "17: G8v-a1-v4-vs-M2v; 18: G8v-a1-v4-vs-F2vG"), bty="n")

