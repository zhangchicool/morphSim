library(vioplot)

setwd("~/Documents/Research/2022-MorphSim/tipdating")

par(mfrow = c(3,2), mar=c(2,2,0,2)+0.5, oma=c(0,2,2,2))


## 1. RF distance ##
d_rf1 <- read.table("mkv-vs-mkv/dist_rf.txt")
d_rf2 <- read.table("fkv-a2-vs-mkv/dist_rf.txt")
d_rf3 <- read.table("fkv-a1-vs-mkv/dist_rf.txt")
d_rf4 <- read.table("fkv-a0.5-vs-mkv/dist_rf.txt")
d_rf5 <- read.table("mkvh-v1-vs-mkv/dist_rf.txt")
d_rf6 <- read.table("fkvh-v1-a2-vs-mkv/dist_rf.txt")
d_rf7 <- read.table("fkvh-v1-a1-vs-mkv/dist_rf.txt")
d_rf8 <- read.table("fkvh-v1-a0.5-vs-mkv/dist_rf.txt")
vioplot(c(d_rf1, d_rf2, d_rf3, d_rf4, d_rf5, d_rf6, d_rf7, d_rf8),
        xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:8, labels=1:8)
legend("topright", "RF distance", bty="n")

d_rf1 <- read.table("mkv-vs-fkv/dist_rf.txt")
d_rf2 <- read.table("fkv-a2-vs-fkv/dist_rf.txt")
d_rf3 <- read.table("fkv-a1-vs-fkv/dist_rf.txt")
d_rf4 <- read.table("fkv-a0.5-vs-fkv/dist_rf.txt")
d_rf5 <- read.table("mkvh-v1-vs-fkv/dist_rf.txt")
d_rf6 <- read.table("fkvh-v1-a2-vs-fkv/dist_rf.txt")
d_rf7 <- read.table("fkvh-v1-a1-vs-fkv/dist_rf.txt")
d_rf8 <- read.table("fkvh-v1-a0.5-vs-fkv/dist_rf.txt")
vioplot(c(d_rf1, d_rf2, d_rf3, d_rf4, d_rf5, d_rf6, d_rf7, d_rf8),
        xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:8, labels=1:8)
legend("topright", "RF distance", bty="n")


## 2. tree height ##
th_estm1 <- read.table("mkv-vs-mkv/th_estm.txt")
th_estm2 <- read.table("fkv-a2-vs-mkv/th_estm.txt")
th_estm3 <- read.table("fkv-a1-vs-mkv/th_estm.txt")
th_estm4 <- read.table("fkv-a0.5-vs-mkv/th_estm.txt")
th_estm5 <- read.table("mkvh-v1-vs-mkv/th_estm.txt")
th_estm6 <- read.table("fkvh-v1-a2-vs-mkv/th_estm.txt")
th_estm7 <- read.table("fkvh-v1-a1-vs-mkv/th_estm.txt")
th_estm8 <- read.table("fkvh-v1-a0.5-vs-mkv/th_estm.txt")
# relative bias
th_bias1 <- (th_estm1$V2 - 1.0) / 1.0
th_bias2 <- (th_estm2$V2 - 1.0) / 1.0
th_bias3 <- (th_estm3$V2 - 1.0) / 1.0
th_bias4 <- (th_estm4$V2 - 1.0) / 1.0
th_bias5 <- (th_estm5$V2 - 1.0) / 1.0
th_bias6 <- (th_estm6$V2 - 1.0) / 1.0
th_bias7 <- (th_estm7$V2 - 1.0) / 1.0
th_bias8 <- (th_estm8$V2 - 1.0) / 1.0
# coverage proportion
th_covp1 <- sum(th_estm1$V4 < 1.0 & th_estm1$V5 > 1.0) / 100
th_covp2 <- sum(th_estm2$V4 < 1.0 & th_estm2$V5 > 1.0) / 100
th_covp3 <- sum(th_estm3$V4 < 1.0 & th_estm3$V5 > 1.0) / 100
th_covp4 <- sum(th_estm4$V4 < 1.0 & th_estm4$V5 > 1.0) / 100
th_covp5 <- sum(th_estm5$V4 < 1.0 & th_estm5$V5 > 1.0) / 100
th_covp6 <- sum(th_estm6$V4 < 1.0 & th_estm6$V5 > 1.0) / 100
th_covp7 <- sum(th_estm7$V4 < 1.0 & th_estm7$V5 > 1.0) / 100
th_covp8 <- sum(th_estm8$V4 < 1.0 & th_estm8$V5 > 1.0) / 100

vioplot(th_bias1, th_bias2, th_bias3, th_bias4, th_bias5, th_bias6, th_bias7, th_bias8,
        xaxt="n", ylim=c(-0.35,0.22))
par(new=T)
plot(c(0.5,8.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(th_covp1, th_covp2, th_covp3, th_covp4, th_covp5, th_covp6, th_covp7, th_covp8),
       pch=4)
axis(side=1, at=1:8, labels=1:8)
axis(side=4, at=seq(0,1,0.2), labels=F)
legend("topright", "tree height", bty="n")

th_estm1 <- read.table("mkv-vs-fkv/th_estm.txt")
th_estm2 <- read.table("fkv-a2-vs-fkv/th_estm.txt")
th_estm3 <- read.table("fkv-a1-vs-fkv/th_estm.txt")
th_estm4 <- read.table("fkv-a0.5-vs-fkv/th_estm.txt")
th_estm5 <- read.table("mkvh-v1-vs-fkv/th_estm.txt")
th_estm6 <- read.table("fkvh-v1-a2-vs-fkv/th_estm.txt")
th_estm7 <- read.table("fkvh-v1-a1-vs-fkv/th_estm.txt")
th_estm8 <- read.table("fkvh-v1-a0.5-vs-fkv/th_estm.txt")
# relative bias
th_bias1 <- (th_estm1$V2 - 1.0) / 1.0
th_bias2 <- (th_estm2$V2 - 1.0) / 1.0
th_bias3 <- (th_estm3$V2 - 1.0) / 1.0
th_bias4 <- (th_estm4$V2 - 1.0) / 1.0
th_bias5 <- (th_estm5$V2 - 1.0) / 1.0
th_bias6 <- (th_estm6$V2 - 1.0) / 1.0
th_bias7 <- (th_estm7$V2 - 1.0) / 1.0
th_bias8 <- (th_estm8$V2 - 1.0) / 1.0
# coverage proportion
th_covp1 <- sum(th_estm1$V4 < 1.0 & th_estm1$V5 > 1.0) / 100
th_covp2 <- sum(th_estm2$V4 < 1.0 & th_estm2$V5 > 1.0) / 100
th_covp3 <- sum(th_estm3$V4 < 1.0 & th_estm3$V5 > 1.0) / 100
th_covp4 <- sum(th_estm4$V4 < 1.0 & th_estm4$V5 > 1.0) / 100
th_covp5 <- sum(th_estm5$V4 < 1.0 & th_estm5$V5 > 1.0) / 100
th_covp6 <- sum(th_estm6$V4 < 1.0 & th_estm6$V5 > 1.0) / 100
th_covp7 <- sum(th_estm7$V4 < 1.0 & th_estm7$V5 > 1.0) / 100
th_covp8 <- sum(th_estm8$V4 < 1.0 & th_estm8$V5 > 1.0) / 100

vioplot(th_bias1, th_bias2, th_bias3, th_bias4, th_bias5, th_bias6, th_bias7, th_bias8,
        xaxt="n", ylim=c(-0.35,0.22))
par(new=T)
plot(c(0.5,8.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(th_covp1, th_covp2, th_covp3, th_covp4, th_covp5, th_covp6, th_covp7, th_covp8),
       pch=4)
axis(side=1, at=1:8, labels=1:8)
axis(side=4, at=seq(0,1,0.2))
legend("topright", "tree height", bty="n")


## 3. clock rate ##
cl_estm1 <- read.table("mkv-vs-mkv/cl_estm.txt")
cl_estm2 <- read.table("fkv-a2-vs-mkv/cl_estm.txt")
cl_estm3 <- read.table("fkv-a1-vs-mkv/cl_estm.txt")
cl_estm4 <- read.table("fkv-a0.5-vs-mkv/cl_estm.txt")
cl_estm5 <- read.table("mkvh-v1-vs-mkv/cl_estm.txt")
cl_estm6 <- read.table("fkvh-v1-a2-vs-mkv/cl_estm.txt")
cl_estm7 <- read.table("fkvh-v1-a1-vs-mkv/cl_estm.txt")
cl_estm8 <- read.table("fkvh-v1-a0.5-vs-mkv/cl_estm.txt")
# relative bias
cl_bias1 <- (cl_estm1$V2 - 1.0) / 1.0
cl_bias2 <- (cl_estm2$V2 - 1.0) / 1.0
cl_bias3 <- (cl_estm3$V2 - 1.0) / 1.0
cl_bias4 <- (cl_estm4$V2 - 1.0) / 1.0
cl_bias5 <- (cl_estm5$V2 - 1.0) / 1.0
cl_bias6 <- (cl_estm6$V2 - 1.0) / 1.0
cl_bias7 <- (cl_estm7$V2 - 1.0) / 1.0
cl_bias8 <- (cl_estm8$V2 - 1.0) / 1.0
# coverage proportion
cl_covp1 <- sum(cl_estm1$V4 < 1.0 & cl_estm1$V5 > 1.0) / 100
cl_covp2 <- sum(cl_estm2$V4 < 1.0 & cl_estm2$V5 > 1.0) / 100
cl_covp3 <- sum(cl_estm3$V4 < 1.0 & cl_estm3$V5 > 1.0) / 100
cl_covp4 <- sum(cl_estm4$V4 < 1.0 & cl_estm4$V5 > 1.0) / 100
cl_covp5 <- sum(cl_estm5$V4 < 1.0 & cl_estm5$V5 > 1.0) / 100
cl_covp6 <- sum(cl_estm6$V4 < 1.0 & cl_estm6$V5 > 1.0) / 100
cl_covp7 <- sum(cl_estm7$V4 < 1.0 & cl_estm7$V5 > 1.0) / 100
cl_covp8 <- sum(cl_estm8$V4 < 1.0 & cl_estm8$V5 > 1.0) / 100

vioplot(cl_bias1, cl_bias2, cl_bias3, cl_bias4, cl_bias5, cl_bias6, cl_bias7, cl_bias8,
        xaxt="n", ylim=c(-0.7,0.7))
par(new=T)
plot(c(0.5,8.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(cl_covp1, cl_covp2, cl_covp3, cl_covp4, cl_covp5, cl_covp6, cl_covp7, cl_covp8),
       pch=4)
axis(side=1, at=1:8, labels=1:8)
axis(side=4, at=seq(0,1,0.2), labels=F)
legend("topright", "clock rate", bty="n")

cl_estm1 <- read.table("mkv-vs-fkv/cl_estm.txt")
cl_estm2 <- read.table("fkv-a2-vs-fkv/cl_estm.txt")
cl_estm3 <- read.table("fkv-a1-vs-fkv/cl_estm.txt")
cl_estm4 <- read.table("fkv-a0.5-vs-fkv/cl_estm.txt")
cl_estm5 <- read.table("mkvh-v1-vs-fkv/cl_estm.txt")
cl_estm6 <- read.table("fkvh-v1-a2-vs-fkv/cl_estm.txt")
cl_estm7 <- read.table("fkvh-v1-a1-vs-fkv/cl_estm.txt")
cl_estm8 <- read.table("fkvh-v1-a0.5-vs-fkv/cl_estm.txt")
# relative bias
cl_bias1 <- (cl_estm1$V2 - 1.0) / 1.0
cl_bias2 <- (cl_estm2$V2 - 1.0) / 1.0
cl_bias3 <- (cl_estm3$V2 - 1.0) / 1.0
cl_bias4 <- (cl_estm4$V2 - 1.0) / 1.0
cl_bias5 <- (cl_estm5$V2 - 1.0) / 1.0
cl_bias6 <- (cl_estm6$V2 - 1.0) / 1.0
cl_bias7 <- (cl_estm7$V2 - 1.0) / 1.0
cl_bias8 <- (cl_estm8$V2 - 1.0) / 1.0
# coverage proportion
cl_covp1 <- sum(cl_estm1$V4 < 1.0 & cl_estm1$V5 > 1.0) / 100
cl_covp2 <- sum(cl_estm2$V4 < 1.0 & cl_estm2$V5 > 1.0) / 100
cl_covp3 <- sum(cl_estm3$V4 < 1.0 & cl_estm3$V5 > 1.0) / 100
cl_covp4 <- sum(cl_estm4$V4 < 1.0 & cl_estm4$V5 > 1.0) / 100
cl_covp5 <- sum(cl_estm5$V4 < 1.0 & cl_estm5$V5 > 1.0) / 100
cl_covp6 <- sum(cl_estm6$V4 < 1.0 & cl_estm6$V5 > 1.0) / 100
cl_covp7 <- sum(cl_estm7$V4 < 1.0 & cl_estm7$V5 > 1.0) / 100
cl_covp8 <- sum(cl_estm8$V4 < 1.0 & cl_estm8$V5 > 1.0) / 100

vioplot(cl_bias1, cl_bias2, cl_bias3, cl_bias4, cl_bias5, cl_bias6, cl_bias7, cl_bias8,
        xaxt="n", ylim=c(-0.3,1.6))
par(new=T)
plot(c(0.5,8.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(cl_covp1, cl_covp2, cl_covp3, cl_covp4, cl_covp5, cl_covp6, cl_covp7, cl_covp8),
       pch=4)
axis(side=1, at=1:8, labels=1:8)
axis(side=4, at=seq(0,1,0.2))
legend("topright", "clock rate", bty="n")


mtext("normalized distance", side=2, line=0,   adj=0.90, outer=T)
mtext("relative bias",       side=2, line=0,   adj=0.51, outer=T)
mtext("coverage proportion", side=4, line=0,   adj=0.51, outer=T)
mtext("relative bias",       side=2, line=0,   adj=0.15, outer=T)
mtext("coverage proportion", side=4, line=0,   adj=0.15, outer=T)
mtext("Mkv in inference",    side=3, line=0.5, adj=0.20, outer=T)
mtext("Fkv in inference",    side=3, line=0.5, adj=0.80, outer=T)

