require(ggplot2)
require(dplyr)

# ===========Main Section=====================================#
dat <- read.csv("2016_17Season.csv", header = T, sep = '\t')
dat1 <- dat %>% select(FGM, FG., X3PM, X3P., FTM, FT., OREB, DREB, AST, STL, BLK)
scalingfunc <- function(x) {return (x^{0.1})}
mydat <- apply(dat1, MARGIN = c(1,2), FUN = scalingfunc)
distances <- dist(mydat, method="minkowski", p = 2)
x2d_fit <- cmdscale(distances, eig = TRUE, k = 2)
x2d_fit
x <- x2d_fit$points[,1]
y <- x2d_fit$points[,2]
plotdat <- data.frame(x, y, dat$TEAM)
ggplot(plotdat, aes(x, y, label = dat.TEAM)) +
  geom_text(hjust=0.15, vjust=0.1, cex=3) +
  geom_point() +
  scale_x_reverse() +
  xlab("x-coordinate") +
  ylab("y-coordinate") +
  ggtitle("MDS") +
  geom_abline(intercept =0.01, slope = 1, col='blue')

# Check the goodness of fit
x2d_fit$GOF

# Check correlation 
cor(x, mydat)
cor(y, mydat)

# Check the offensive/defensive data
offdata <- data.frame(mydat) %>%
  select(X3PM, X3P., AST)
off <- rowSums(offdata)
defdata <- data.frame(mydat) %>%
  select(FGM, AST, STL, BLK)
def <- rowSums(defdata)
plotdata1 <- data.frame(off, def, dat$TEAM)
ggplot(plotdata1, aes(off, def, label = dat.TEAM)) + 
  geom_text(hjust=0.15, vjust=0.1) + 
  geom_point()

# Check offensive/defensive from table data
rtg <- read.csv("2016_17OFFDEF.csv", header = T, sep = ',')
offdef <- rtg %>% select(TEAM, OFFRTG, DEFRTG)
offdef

# Check 3-Dimensional MDS
#https://statmethods.wordpress.com/2012/01/30/getting-fancy-with-3-d-scatterplots/
x3d_fit <- cmdscale(distances, eig = TRUE, k = 3)
x3d_fit
x <- x3d_fit$points[,1]
y <- x3d_fit$points[,2]
z <- x3d_fit$points[,3]
plotdata2 <- data.frame(x, y, z, dat$TEAM)
library(scatterplot3d)
with(plotdata2, {
  s3d <- scatterplot3d(x, y, z,        # x y and z axis
                       color="blue", pch=19,        # filled blue circles
                       type="h",                    # vertical lines to the x-y plane
                       main="MDS in 3D",
                       xlab="x",
                       ylab="y",
                       zlab="z")
  s3d.coords <- s3d$xyz.convert(x, y, z) # convert 3D coords to 2D projection
  text(s3d.coords$x, s3d.coords$y,             # x and y coordinates
       labels=dat$TEAM,               # text to plot
       cex=0.8, pos=4)           # shrink text 50% and place to right of points)
})

# Check 1-Dimensional MDS
x1d_fit <- cmdscale(distances, eig = TRUE, k = 1)
x <- x1d_fit$points[,1]
plot(0, xlim = c(min(x), max(x)), axes=FALSE, type = "n", xlab = "", ylab = "")
axis(1, at = x, labels = dat$TEAM)
# ============================================================#


# Adjustment: Data From Season 2015-2016======================#
dat11 <- read.csv("2015_16Season.csv", header = T, sep = ',')
dat111 <- dat11 %>% select(FGM, FG., X3PM, X3P., FTM, FT., OREB, DREB, AST, STL, BLK)
mydat1 <- apply(dat111, MARGIN = c(1,2), FUN = scalingfunc)
distances1 <- dist(mydat1, method="minkowski", p = 2)
x2d_fit1 <- cmdscale(distances1, eig = TRUE, k = 2)
x2d_fit1
x1 <- x2d_fit1$points[,1]
y1 <- x2d_fit1$points[,2]
plotdat1 <- data.frame(x1, y1, dat11$TEAM)
ggplot(plotdat1, aes(x1, y1, label = dat11.TEAM)) +
  geom_text(hjust=0.15, vjust=0.1, cex=3) +
  geom_point() +
  scale_x_reverse() +
  xlab("x-coordinate") +
  ylab("y-coordinate") +
  ggtitle("MDS")

x2d_fit1$GOF

rtg1 <- read.csv("2015_16OFFDEF.csv", header = T, sep = '\t')
offdef1 <- rtg1 %>% select(TEAM, OFFRTG, DEFRTG)
offdef1

# Extension: Data From Season 2017-2018=========================#
dat2 <- read.csv("2017_18Season.csv", header = T, sep = '\t')
dat22 <- dat2 %>% select(FGM, FG., X3PM, X3P., FTM, FT., OREB, DREB, AST, STL, BLK)
mydat2 <- apply(dat22, MARGIN = c(1,2), FUN = scalingfunc)
distances2 <- dist(mydat2, method="minkowski", p = 2)
x2d_fit2 <- cmdscale(distances2, eig = TRUE, k = 2)
x2 <- x2d_fit2$points[,1]
y2 <- x2d_fit2$points[,2]
plotdat2 <- data.frame(x2, y2, dat2$TEAM)
ggplot(plotdat2, aes(x2, y2, label = dat2.TEAM)) +
  geom_text(hjust=0.15, vjust=0.1, cex=3) +
  geom_point() +
  scale_x_reverse() +
  xlab("x-coordinate") +
  ylab("y-coordinate") +
  ggtitle("MDS")