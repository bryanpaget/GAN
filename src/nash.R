x <- 0.5
y <- 0.5
alpha <- 0.08

f <- function(x, y) {
  x * y
}

g <- function(x, y) {
  log(x) + log(1 - x * y)
}

n <- function(x, y) {
    log(x) - log(x * y)
}

update.nx <- function(x, y, alpha) {
    x + alpha * (1 / x + y / (1 - x * y))
}

update.ny <- function(x, y, alpha) {
    y + alpha * (1 / y)
}

update.gx <- function(x, y, alpha) {
  x + alpha * (1 / x + y / (1 - x * y))
}

update.gy <- function(x, y, alpha) {
  y - alpha * (x / (1 - x * y))
}

update.fx <- function(x, y, alpha) {
  x - alpha * y
}

update.fy <- function(x, y, alpha) {
  y + alpha * x
}

update <- function(f1, f2, x, y, alpha) {
  c(f1(x, y, alpha),
    f2(x, y, alpha))
}

# Little Demo
fs <- c()
xs <- c(x)
ys <- c(y)
for (i in 1:500) {
  new.values <- update(update.fx,
                       update.fy,
                       xs[i],
                       ys[i],
                       alpha)
  xs <- c(xs, new.values[1])
  ys <- c(ys, new.values[2])
  fs <- c(fs, f(new.values[1], new.values[2]))
}

png("plot1.png",
    width     = 3.25,
    height    = 3.25,
    units     = "in",
    res       = 300,
    pointsize = 6)
plot(xs,
     type = "l",
     col = "blue",
     xlab = "Iteration",
     ylab = "",
     ylim = c(-5, 5))
lines(ys, col = "red")
lines(fs, col = "purple")
legend("topleft", legend = c("x", "y", "V(x,y)"),
       col = c("blue", "red", "purple"),
       lty = c(1, 1, 1),
       cex = 1)
dev.off()

# Saturating GAN
gs <- c()
xs <- c(x)
ys <- c(y)
for (i in 1:500) {
  new.values <- update(update.gx,
                       update.gy,
                       xs[i],
                       ys[i],
                       alpha)
  xs <- c(xs, new.values[1])
  ys <- c(ys, new.values[2])
  gs <- c(gs, g(new.values[1], new.values[2]))
}

png("plot2.png",
    width     = 3.25,
    height    = 3.25,
    units     = "in",
    res       = 300,
    pointsize = 6)
plot(xs,
     type = "l",
     xlab = "Iteration",
     ylab = "",
     col = "blue",
     ylim = c(-5, 5))
lines(ys, col = "red")
lines(gs, col = "purple")
legend("topleft", legend = c("x", "y", "V(x,y)"),
       col = c("blue", "red", "purple"),
       lty = c(1, 1, 1),
       cex = 1)
dev.off()

# Non saturating GAN
ns <- c()
xs <- c(x)
ys <- c(y)
for (i in 1:500) {
    new.values <- update(update.nx,
                         update.ny,
                         xs[i],
                         ys[i],
                         alpha)
    xs <- c(xs, new.values[1])
    ys <- c(ys, new.values[2])
    ns <- c(ns, n(new.values[1], new.values[2]))
}

png("plot3.png",
    width     = 3.25,
    height    = 3.25,
    units     = "in",
    res       = 300,
    pointsize = 6)
plot(xs,
     type = "l",
     xlab = "Iteration",
     ylab = "",
     col = "blue",
     ylim = c(-5, 5))
lines(ys, col = "red")
lines(ns, col = "purple")
legend("topleft", legend = c("x", "y", "V(x,y)"),
       col = c("blue", "red", "purple"),
       lty = c(1, 1, 1),
       cex = 1)
dev.off()
