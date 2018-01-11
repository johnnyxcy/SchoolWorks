# Lecture8-2
data <- read.csv(file.choose(), header = T)
# Define x to be the number of goals out of 8 total tries
x <- data[, 1]
# My gusees is lambda is about 2 goals out of 8 tries

plot(x, dpois(x, 2), type = "b")

dpois(0, 2)
# p(x = 0) means the proportion that x = 0 takes