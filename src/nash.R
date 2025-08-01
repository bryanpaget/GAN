#' GAN Dynamics Simulation Functions
#' 
#' This package provides functions to simulate and visualize the dynamics of 
#' Generative Adversarial Networks (GANs) using different objective functions.
#' The code demonstrates the oscillatory behavior often observed in GAN training 
#' through three different scenarios: a simple minimax game, a saturating GAN, 
#' and a non-saturating GAN.
#'
#' @author Bryan Paget
#' @email bryan.paget@example.com

#' Value function for simple minimax game
#'
#' @param x First parameter (discriminator-related)
#' @param y Second parameter (generator-related)
#' @return The product x * y
#' @examples
#' f(0.5, 0.5)
f <- function(x, y) {
  x * y
}

#' Value function for saturating GAN
#'
#' This function represents the saturating loss function used in the original 
#' GAN formulation, which can lead to vanishing gradients early in training.
#'
#' @param x First parameter (discriminator-related)
#' @param y Second parameter (generator-related)
#' @return The value log(x) + log(1 - x*y)
#' @examples
#' g(0.5, 0.5)
g <- function(x, y) {
  log(x) + log(1 - x * y)
}

#' Value function for non-saturating GAN
#'
#' This function represents the non-saturating loss function that provides 
#' stronger gradients for the generator, improving training stability.
#'
#' @param x First parameter (discriminator-related)
#' @param y Second parameter (generator-related)
#' @return The value log(x) - log(x*y)
#' @examples
#' n(0.5, 0.5)
n <- function(x, y) {
  log(x) - log(x * y)
}

#' Update rule for x parameter in non-saturating GAN
#'
#' @param x Current value of x
#' @param y Current value of y
#' @param alpha Learning rate
#' @return Updated value of x
update.nx <- function(x, y, alpha) {
  x + alpha * (1 / x + y / (1 - x * y))
}

#' Update rule for y parameter in non-saturating GAN
#'
#' @param x Current value of x
#' @param y Current value of y
#' @param alpha Learning rate
#' @return Updated value of y
update.ny <- function(x, y, alpha) {
  y + alpha * (1 / y)
}

#' Update rule for x parameter in saturating GAN
#'
#' @param x Current value of x
#' @param y Current value of y
#' @param alpha Learning rate
#' @return Updated value of x
update.gx <- function(x, y, alpha) {
  x + alpha * (1 / x + y / (1 - x * y))
}

#' Update rule for y parameter in saturating GAN
#'
#' @param x Current value of x
#' @param y Current value of y
#' @param alpha Learning rate
#' @return Updated value of y
update.gy <- function(x, y, alpha) {
  y - alpha * (x / (1 - x * y))
}

#' Update rule for x parameter in simple minimax game
#'
#' @param x Current value of x
#' @param y Current value of y
#' @param alpha Learning rate
#' @return Updated value of x
update.fx <- function(x, y, alpha) {
  x - alpha * y
}

#' Update rule for y parameter in simple minimax game
#'
#' @param x Current value of x
#' @param y Current value of y
#' @param alpha Learning rate
#' @return Updated value of y
update.fy <- function(x, y, alpha) {
  y + alpha * x
}

#' Generic update function for parameters
#'
#' @param f1 Update function for first parameter
#' @param f2 Update function for second parameter
#' @param x Current value of first parameter
#' @param y Current value of second parameter
#' @param alpha Learning rate
#' @return Vector with updated values of x and y
update <- function(f1, f2, x, y, alpha) {
  c(f1(x, y, alpha),
    f2(x, y, alpha))
}

#' Run simulation and generate plot
#'
#' @param x Initial value of x
#' @param y Initial value of y
#' @param alpha Learning rate
#' @param f1 Update function for x
#' @param f2 Update function for y
#' @param value_fn Value function to track
#' @param filename Output filename for plot
#' @param title Plot title
#' @param iterations Number of iterations to simulate
#' @param width Plot width in inches
#' @param height Plot height in inches
#' @return Invisible list with x, y, and value trajectories
run_simulation <- function(x, y, alpha, f1, f2, value_fn, filename, 
                           title, iterations = 500, width = 3.25, height = 3.25) {
  
  # Initialize vectors to store values
  xs <- c(x)
  ys <- c(y)
  values <- c(value_fn(x, y))
  
  # Run simulation
  for (i in 1:iterations) {
    new.values <- update(f1, f2, xs[i], ys[i], alpha)
    xs <- c(xs, new.values[1])
    ys <- c(ys, new.values[2])
    values <- c(values, value_fn(new.values[1], new.values[2]))
  }
  
  # Generate plot
  png(filename,
      width     = width,
      height    = height,
      units     = "in",
      res       = 300,
      pointsize = 6)
  
  plot(xs,
       type = "l",
       col = "blue",
       xlab = "Iteration",
       ylab = "Value",
       ylim = c(-5, 5),
       main = title)
  lines(ys, col = "red")
  lines(values, col = "purple")
  legend("topleft", 
         legend = c("x", "y", "V(x,y)"),
         col = c("blue", "red", "purple"),
         lty = c(1, 1, 1),
         cex = 1)
  dev.off()
  
  # Return trajectories invisibly
  invisible(list(x = xs, y = ys, value = values))
}

#' Run all GAN simulations
#'
#' This function runs three simulations demonstrating different GAN dynamics:
#' 1. Simple minimax game
#' 2. Saturating GAN
#' 3. Non-saturating GAN
#'
#' @param x Initial value of x (default: 0.5)
#' @param y Initial value of y (default: 0.5)
#' @param alpha Learning rate (default: 0.08)
#' @param iterations Number of iterations for each simulation (default: 500)
#' @return Invisible list with simulation results
run_all_simulations <- function(x = 0.5, y = 0.5, alpha = 0.08, iterations = 500) {
  
  # Run simple minimax game simulation
  cat("Running simple minimax game simulation...\n")
  sim1 <- run_simulation(
    x = x, y = y, alpha = alpha,
    f1 = update.fx, f2 = update.fy,
    value_fn = f,
    filename = "plot1.png",
    title = "Simple Minimax Game",
    iterations = iterations
  )
  
  # Run saturating GAN simulation
  cat("Running saturating GAN simulation...\n")
  sim2 <- run_simulation(
    x = x, y = y, alpha = alpha,
    f1 = update.gx, f2 = update.gy,
    value_fn = g,
    filename = "plot2.png",
    title = "Saturating GAN",
    iterations = iterations
  )
  
  # Run non-saturating GAN simulation
  cat("Running non-saturating GAN simulation...\n")
  sim3 <- run_simulation(
    x = x, y = y, alpha = alpha,
    f1 = update.nx, f2 = update.ny,
    value_fn = n,
    filename = "plot3.png",
    title = "Non-Saturating GAN",
    iterations = iterations
  )
  
  cat("All simulations complete. Plots saved as plot1.png, plot2.png, and plot3.png\n")
  
  # Return all simulation results invisibly
  invisible(list(
    minimax = sim1,
    saturating = sim2,
    non_saturating = sim3
  ))
}

# Example usage:
# Run all simulations with default parameters
# results <- run_all_simulations()

# Or run with custom parameters
# results <- run_all_simulations(x = 0.3, y = 0.7, alpha = 0.05, iterations = 1000)