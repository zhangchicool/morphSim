library(vioplot)

setwd("~/Documents/Research/2022-MorphSim/tipdating/")

par(mfrow = c(3,2), mar=c(2,2,0,2)+0.5, oma=c(0,2,2,2))


## 1. RF distance ##
d_rf1  <- read.table("mkv-vs-mkv/dist_rf.txt")
d_rf2  <- read.table("fkv-a2-vs-mkv/dist_rf.txt")
d_rf3  <- read.table("fkv-a1-vs-mkv/dist_rf.txt")
d_rf4  <- read.table("fkv-a0.5-vs-mkv/dist_rf.txt")
d_rf5  <- read.table("mkvh-v1-vs-mkv/dist_rf.txt")
d_rf6  <- read.table("fkvh-v1-a2-vs-mkv/dist_rf.txt")
d_rf7  <- read.table("fkvh-v1-a1-vs-mkv/dist_rf.txt")
d_rf8  <- read.table("fkvh-v1-a0.5-vs-mkv/dist_rf.txt")
d_rf9  <- read.table("mkvh-v4-vs-mkv/dist_rf.txt")
d_rf10 <- read.table("fkvh-v4-a2-vs-mkv/dist_rf.txt")
d_rf11 <- read.table("fkvh-v4-a1-vs-mkv/dist_rf.txt")
d_rf12 <- read.table("fkvh-v4-a0.5-vs-mkv/dist_rf.txt")
vioplot(c(d_rf1, d_rf2, d_rf3, d_rf4, 
          d_rf5, d_rf6, d_rf7, d_rf8,
          d_rf9, d_rf10, d_rf11, d_rf12), xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:12, labels=1:12)
legend("topright", "RF distance", bty="n")

d_rf1  <- read.table("mkv-vs-fkv/dist_rf.txt")
d_rf2  <- read.table("fkv-a2-vs-fkv/dist_rf.txt")
d_rf3  <- read.table("fkv-a1-vs-fkv/dist_rf.txt")
d_rf4  <- read.table("fkv-a0.5-vs-fkv/dist_rf.txt")
d_rf5  <- read.table("mkvh-v1-vs-fkv/dist_rf.txt")
d_rf6  <- read.table("fkvh-v1-a2-vs-fkv/dist_rf.txt")
d_rf7  <- read.table("fkvh-v1-a1-vs-fkv/dist_rf.txt")
d_rf8  <- read.table("fkvh-v1-a0.5-vs-fkv/dist_rf.txt")
d_rf9  <- read.table("mkvh-v4-vs-fkv/dist_rf.txt")
d_rf10 <- read.table("fkvh-v4-a2-vs-fkv/dist_rf.txt")
d_rf11 <- read.table("fkvh-v4-a1-vs-fkv/dist_rf.txt")
d_rf12 <- read.table("fkvh-v4-a0.5-vs-fkv/dist_rf.txt")
vioplot(c(d_rf1, d_rf2, d_rf3, d_rf4, 
          d_rf5, d_rf6, d_rf7, d_rf8,
          d_rf9, d_rf10, d_rf11, d_rf12), xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:12, labels=1:12)
legend("topright", "RF distance", bty="n")


## 2. tree height ##
tl_estm1  <- read.table("mkv-vs-mkv/th_estm.txt")
tl_estm2  <- read.table("fkv-a2-vs-mkv/th_estm.txt")
tl_estm3  <- read.table("fkv-a1-vs-mkv/th_estm.txt")
tl_estm4  <- read.table("fkv-a0.5-vs-mkv/th_estm.txt")
tl_estm5  <- read.table("mkvh-v1-vs-mkv/th_estm.txt")
tl_estm6  <- read.table("fkvh-v1-a2-vs-mkv/th_estm.txt")
tl_estm7  <- read.table("fkvh-v1-a1-vs-mkv/th_estm.txt")
tl_estm8  <- read.table("fkvh-v1-a0.5-vs-mkv/th_estm.txt")
tl_estm9  <- read.table("mkvh-v4-vs-mkv/th_estm.txt")
tl_estm10 <- read.table("fkvh-v4-a2-vs-mkv/th_estm.txt")
tl_estm11 <- read.table("fkvh-v4-a1-vs-mkv/th_estm.txt")
tl_estm12 <- read.table("fkvh-v4-a0.5-vs-mkv/th_estm.txt")
# relative bias
tl_bias1  <- (tl_estm1$V2 - 1.0) / 1.0
tl_bias2  <- (tl_estm2$V2 - 1.0) / 1.0
tl_bias3  <- (tl_estm3$V2 - 1.0) / 1.0
tl_bias4  <- (tl_estm4$V2 - 1.0) / 1.0
tl_bias5  <- (tl_estm5$V2 - 1.0) / 1.0
tl_bias6  <- (tl_estm6$V2 - 1.0) / 1.0
tl_bias7  <- (tl_estm7$V2 - 1.0) / 1.0
tl_bias8  <- (tl_estm8$V2 - 1.0) / 1.0
tl_bias9  <- (tl_estm9$V2 - 1.0) / 1.0
tl_bias10 <- (tl_estm10$V2- 1.0) / 1.0
tl_bias11 <- (tl_estm11$V2- 1.0) / 1.0
tl_bias12 <- (tl_estm12$V2- 1.0) / 1.0
# coverage proportion
tl_covp1  <- sum(tl_estm1$V4 < 1.0 & tl_estm1$V5 > 1.0) / 100
tl_covp2  <- sum(tl_estm2$V4 < 1.0 & tl_estm2$V5 > 1.0) / 100
tl_covp3  <- sum(tl_estm3$V4 < 1.0 & tl_estm3$V5 > 1.0) / 100
tl_covp4  <- sum(tl_estm4$V4 < 1.0 & tl_estm4$V5 > 1.0) / 100
tl_covp5  <- sum(tl_estm5$V4 < 1.0 & tl_estm5$V5 > 1.0) / 100
tl_covp6  <- sum(tl_estm6$V4 < 1.0 & tl_estm6$V5 > 1.0) / 100
tl_covp7  <- sum(tl_estm7$V4 < 1.0 & tl_estm7$V5 > 1.0) / 100
tl_covp8  <- sum(tl_estm8$V4 < 1.0 & tl_estm8$V5 > 1.0) / 100
tl_covp9  <- sum(tl_estm9$V4 < 1.0 & tl_estm9$V5 > 1.0) / 100
tl_covp10 <- sum(tl_estm10$V4< 1.0 & tl_estm10$V5> 1.0) / 100
tl_covp11 <- sum(tl_estm11$V4< 1.0 & tl_estm11$V5> 1.0) / 100
tl_covp12 <- sum(tl_estm12$V4< 1.0 & tl_estm12$V5> 1.0) / 100

vioplot(tl_bias1, tl_bias2, tl_bias3, tl_bias4,
        tl_bias5, tl_bias6, tl_bias7, tl_bias8,
        tl_bias9, tl_bias10, tl_bias11, tl_bias12,  xaxt="n", ylim=c(-0.4,0.2))
par(new=T)
plot(c(0.5,12.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(tl_covp1, tl_covp2, tl_covp3, tl_covp4,
         tl_covp5, tl_covp6, tl_covp7, tl_covp8,
         tl_covp9, tl_covp10, tl_covp11, tl_covp12), pch=4)
axis(side=1, at=1:12, labels=1:12)
axis(side=4, at=seq(0,1,0.2), labels=F)
legend("topright", "tree height", bty="n")

tl_estm1  <- read.table("mkv-vs-fkv/th_estm.txt")
tl_estm2  <- read.table("fkv-a2-vs-fkv/th_estm.txt")
tl_estm3  <- read.table("fkv-a1-vs-fkv/th_estm.txt")
tl_estm4  <- read.table("fkv-a0.5-vs-fkv/th_estm.txt")
tl_estm5  <- read.table("mkvh-v1-vs-fkv/th_estm.txt")
tl_estm6  <- read.table("fkvh-v1-a2-vs-fkv/th_estm.txt")
tl_estm7  <- read.table("fkvh-v1-a1-vs-fkv/th_estm.txt")
tl_estm8  <- read.table("fkvh-v1-a0.5-vs-fkv/th_estm.txt")
tl_estm9  <- read.table("mkvh-v4-vs-fkv/th_estm.txt")
tl_estm10 <- read.table("fkvh-v4-a2-vs-fkv/th_estm.txt")
tl_estm11 <- read.table("fkvh-v4-a1-vs-fkv/th_estm.txt")
tl_estm12 <- read.table("fkvh-v4-a0.5-vs-fkv/th_estm.txt")
# relative bias
tl_bias1  <- (tl_estm1$V2 - 1.0) / 1.0
tl_bias2  <- (tl_estm2$V2 - 1.0) / 1.0
tl_bias3  <- (tl_estm3$V2 - 1.0) / 1.0
tl_bias4  <- (tl_estm4$V2 - 1.0) / 1.0
tl_bias5  <- (tl_estm5$V2 - 1.0) / 1.0
tl_bias6  <- (tl_estm6$V2 - 1.0) / 1.0
tl_bias7  <- (tl_estm7$V2 - 1.0) / 1.0
tl_bias8  <- (tl_estm8$V2 - 1.0) / 1.0
tl_bias9  <- (tl_estm9$V2 - 1.0) / 1.0
tl_bias10 <- (tl_estm10$V2- 1.0) / 1.0
tl_bias11 <- (tl_estm11$V2- 1.0) / 1.0
tl_bias12 <- (tl_estm12$V2- 1.0) / 1.0
# coverage proportion
tl_covp1  <- sum(tl_estm1$V4 < 1.0 & tl_estm1$V5 > 1.0) / 100
tl_covp2  <- sum(tl_estm2$V4 < 1.0 & tl_estm2$V5 > 1.0) / 100
tl_covp3  <- sum(tl_estm3$V4 < 1.0 & tl_estm3$V5 > 1.0) / 100
tl_covp4  <- sum(tl_estm4$V4 < 1.0 & tl_estm4$V5 > 1.0) / 100
tl_covp5  <- sum(tl_estm5$V4 < 1.0 & tl_estm5$V5 > 1.0) / 100
tl_covp6  <- sum(tl_estm6$V4 < 1.0 & tl_estm6$V5 > 1.0) / 100
tl_covp7  <- sum(tl_estm7$V4 < 1.0 & tl_estm7$V5 > 1.0) / 100
tl_covp8  <- sum(tl_estm8$V4 < 1.0 & tl_estm8$V5 > 1.0) / 100
tl_covp9  <- sum(tl_estm9$V4 < 1.0 & tl_estm9$V5 > 1.0) / 100
tl_covp10 <- sum(tl_estm10$V4< 1.0 & tl_estm10$V5> 1.0) / 100
tl_covp11 <- sum(tl_estm11$V4< 1.0 & tl_estm11$V5> 1.0) / 100
tl_covp12 <- sum(tl_estm12$V4< 1.0 & tl_estm12$V5> 1.0) / 100

vioplot(tl_bias1, tl_bias2, tl_bias3, tl_bias4,
        tl_bias5, tl_bias6, tl_bias7, tl_bias8,
        tl_bias9, tl_bias10, tl_bias11, tl_bias12,  xaxt="n", ylim=c(-0.4,0.2))
par(new=T)
plot(c(0.5,12.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(tl_covp1, tl_covp2, tl_covp3, tl_covp4,
         tl_covp5, tl_covp6, tl_covp7, tl_covp8,
         tl_covp9, tl_covp10, tl_covp11, tl_covp12), pch=4)
axis(side=1, at=1:12, labels=1:12)
axis(side=4, at=seq(0,1,0.2))
legend("topright", "tree height", bty="n")


## 3. clock rate ##
cl_estm1  <- read.table("mkv-vs-mkv/cl_estm.txt")
cl_estm2  <- read.table("fkv-a2-vs-mkv/cl_estm.txt")
cl_estm3  <- read.table("fkv-a1-vs-mkv/cl_estm.txt")
cl_estm4  <- read.table("fkv-a0.5-vs-mkv/cl_estm.txt")
cl_estm5  <- read.table("mkvh-v1-vs-mkv/cl_estm.txt")
cl_estm6  <- read.table("fkvh-v1-a2-vs-mkv/cl_estm.txt")
cl_estm7  <- read.table("fkvh-v1-a1-vs-mkv/cl_estm.txt")
cl_estm8  <- read.table("fkvh-v1-a0.5-vs-mkv/cl_estm.txt")
cl_estm9  <- read.table("mkvh-v4-vs-mkv/cl_estm.txt")
cl_estm10 <- read.table("fkvh-v4-a2-vs-mkv/cl_estm.txt")
cl_estm11 <- read.table("fkvh-v4-a1-vs-mkv/cl_estm.txt")
cl_estm12 <- read.table("fkvh-v4-a0.5-vs-mkv/cl_estm.txt")
# relative bias
cl_bias1  <- (cl_estm1$V2 - 1.0) / 1.0
cl_bias2  <- (cl_estm2$V2 - 1.0) / 1.0
cl_bias3  <- (cl_estm3$V2 - 1.0) / 1.0
cl_bias4  <- (cl_estm4$V2 - 1.0) / 1.0
cl_bias5  <- (cl_estm5$V2 - 1.0) / 1.0
cl_bias6  <- (cl_estm6$V2 - 1.0) / 1.0
cl_bias7  <- (cl_estm7$V2 - 1.0) / 1.0
cl_bias8  <- (cl_estm8$V2 - 1.0) / 1.0
cl_bias9  <- (cl_estm9$V2 - 1.0) / 1.0
cl_bias10 <- (cl_estm10$V2- 1.0) / 1.0
cl_bias11 <- (cl_estm11$V2- 1.0) / 1.0
cl_bias12 <- (cl_estm12$V2- 1.0) / 1.0
# coverage proportion
cl_covp1  <- sum(cl_estm1$V4 < 1.0 & cl_estm1$V5 > 1.0) / 100
cl_covp2  <- sum(cl_estm2$V4 < 1.0 & cl_estm2$V5 > 1.0) / 100
cl_covp3  <- sum(cl_estm3$V4 < 1.0 & cl_estm3$V5 > 1.0) / 100
cl_covp4  <- sum(cl_estm4$V4 < 1.0 & cl_estm4$V5 > 1.0) / 100
cl_covp5  <- sum(cl_estm5$V4 < 1.0 & cl_estm5$V5 > 1.0) / 100
cl_covp6  <- sum(cl_estm6$V4 < 1.0 & cl_estm6$V5 > 1.0) / 100
cl_covp7  <- sum(cl_estm7$V4 < 1.0 & cl_estm7$V5 > 1.0) / 100
cl_covp8  <- sum(cl_estm8$V4 < 1.0 & cl_estm8$V5 > 1.0) / 100
cl_covp9  <- sum(cl_estm9$V4 < 1.0 & cl_estm9$V5 > 1.0) / 100
cl_covp10 <- sum(cl_estm10$V4< 1.0 & cl_estm10$V5> 1.0) / 100
cl_covp11 <- sum(cl_estm11$V4< 1.0 & cl_estm11$V5> 1.0) / 100
cl_covp12 <- sum(cl_estm12$V4< 1.0 & cl_estm12$V5> 1.0) / 100

vioplot(cl_bias1, cl_bias2, cl_bias3, cl_bias4,
        cl_bias5, cl_bias6, cl_bias7, cl_bias8,
        cl_bias9, cl_bias10, cl_bias11, cl_bias12,  xaxt="n", ylim=c(-0.7,0.7))
par(new=T)
plot(c(0.5,12.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(cl_covp1, cl_covp2, cl_covp3, cl_covp4,
         cl_covp5, cl_covp6, cl_covp7, cl_covp8,
         cl_covp9, cl_covp10, cl_covp11, cl_covp12), pch=4)
axis(side=1, at=1:12, labels=1:12)
axis(side=4, at=seq(0,1,0.2), labels=F)
legend("topright", "clock rate", bty="n")

cl_estm1  <- read.table("mkv-vs-fkv/cl_estm.txt")
cl_estm2  <- read.table("fkv-a2-vs-fkv/cl_estm.txt")
cl_estm3  <- read.table("fkv-a1-vs-fkv/cl_estm.txt")
cl_estm4  <- read.table("fkv-a0.5-vs-fkv/cl_estm.txt")
cl_estm5  <- read.table("mkvh-v1-vs-fkv/cl_estm.txt")
cl_estm6  <- read.table("fkvh-v1-a2-vs-fkv/cl_estm.txt")
cl_estm7  <- read.table("fkvh-v1-a1-vs-fkv/cl_estm.txt")
cl_estm8  <- read.table("fkvh-v1-a0.5-vs-fkv/cl_estm.txt")
cl_estm9  <- read.table("mkvh-v4-vs-fkv/cl_estm.txt")
cl_estm10 <- read.table("fkvh-v4-a2-vs-fkv/cl_estm.txt")
cl_estm11 <- read.table("fkvh-v4-a1-vs-fkv/cl_estm.txt")
cl_estm12 <- read.table("fkvh-v4-a0.5-vs-fkv/cl_estm.txt")
# relative bias
cl_bias1  <- (cl_estm1$V2 - 1.0) / 1.0
cl_bias2  <- (cl_estm2$V2 - 1.0) / 1.0
cl_bias3  <- (cl_estm3$V2 - 1.0) / 1.0
cl_bias4  <- (cl_estm4$V2 - 1.0) / 1.0
cl_bias5  <- (cl_estm5$V2 - 1.0) / 1.0
cl_bias6  <- (cl_estm6$V2 - 1.0) / 1.0
cl_bias7  <- (cl_estm7$V2 - 1.0) / 1.0
cl_bias8  <- (cl_estm8$V2 - 1.0) / 1.0
cl_bias9  <- (cl_estm9$V2 - 1.0) / 1.0
cl_bias10 <- (cl_estm10$V2- 1.0) / 1.0
cl_bias11 <- (cl_estm11$V2- 1.0) / 1.0
cl_bias12 <- (cl_estm12$V2- 1.0) / 1.0
# coverage proportion
cl_covp1  <- sum(cl_estm1$V4 < 1.0 & cl_estm1$V5 > 1.0) / 100
cl_covp2  <- sum(cl_estm2$V4 < 1.0 & cl_estm2$V5 > 1.0) / 100
cl_covp3  <- sum(cl_estm3$V4 < 1.0 & cl_estm3$V5 > 1.0) / 100
cl_covp4  <- sum(cl_estm4$V4 < 1.0 & cl_estm4$V5 > 1.0) / 100
cl_covp5  <- sum(cl_estm5$V4 < 1.0 & cl_estm5$V5 > 1.0) / 100
cl_covp6  <- sum(cl_estm6$V4 < 1.0 & cl_estm6$V5 > 1.0) / 100
cl_covp7  <- sum(cl_estm7$V4 < 1.0 & cl_estm7$V5 > 1.0) / 100
cl_covp8  <- sum(cl_estm8$V4 < 1.0 & cl_estm8$V5 > 1.0) / 100
cl_covp9  <- sum(cl_estm9$V4 < 1.0 & cl_estm9$V5 > 1.0) / 100
cl_covp10 <- sum(cl_estm10$V4< 1.0 & cl_estm10$V5> 1.0) / 100
cl_covp11 <- sum(cl_estm11$V4< 1.0 & cl_estm11$V5> 1.0) / 100
cl_covp12 <- sum(cl_estm12$V4< 1.0 & cl_estm12$V5> 1.0) / 100

vioplot(cl_bias1, cl_bias2, cl_bias3, cl_bias4,
        cl_bias5, cl_bias6, cl_bias7, cl_bias8,
        cl_bias9, cl_bias10, cl_bias11, cl_bias12,  xaxt="n", ylim=c(-0.5,1.5))
par(new=T)
plot(c(0.5,12.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(cl_covp1, cl_covp2, cl_covp3, cl_covp4,
         cl_covp5, cl_covp6, cl_covp7, cl_covp8,
         cl_covp9, cl_covp10, cl_covp11, cl_covp12), pch=4)
axis(side=1, at=1:12, labels=1:12)
axis(side=4, at=seq(0,1,0.2))
legend("topright", "clock rate", bty="n")


mtext("normalized distance", side=2, line=0,   adj=0.91, outer=T)
mtext("relative bias",       side=2, line=0,   adj=0.51, outer=T)
mtext("coverage proportion", side=4, line=0,   adj=0.51, outer=T)
mtext("relative bias",       side=2, line=0,   adj=0.15, outer=T)
mtext("coverage proportion", side=4, line=0,   adj=0.12, outer=T)
mtext("Mkv in inference",    side=3, line=0.5, adj=0.20, outer=T)
mtext("Fkv in inference",    side=3, line=0.5, adj=0.80, outer=T)

