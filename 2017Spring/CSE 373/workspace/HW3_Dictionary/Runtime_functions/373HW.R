size = c(10, 100, 1000, 5000, 10000)
xrange = range(size)

# insertion
time_insert_SA = c(0.127605, 0.95605, 5.664792, 29.315963, 58.048813)
time_insert_SLL = c(0.70242, 1.98084, 2.943211, 192.91899, 321.832029)
time_insert_UA = c(0.099161, 0.518322, 0.785383, 2.034174, 4.327508)
time_insert_ULL = c(0.67279, 1.144099, 1.265383, 2.718816, 3.630619)
time_insert_BST = c(0.683062, 1.630421, 1.404445, 5.351904, 7.779559)
yrange_insert = range(time_insert_SA)
plot(xrange, yrange_insert, type = "n", xlab = "number of elements to insert", 
     ylab = "Operation Time(ms)")
title("insert()")
lines(size, time_insert_SA, type = "b", lwd = 1.5, col = 2)
lines(size, time_insert_SLL, type = "b", lwd = 1.5, col = 3)
lines(size, time_insert_UA, type = "b", lwd = 1.5, col = 4)
lines(size, time_insert_ULL, type = "b", lwd = 1.5, col = 5)
lines(size, time_insert_BST, type = "b", lwd = 1.5, col = 6)
legend("topleft", c("Sorted Array", "Sorted Linkedlist", "Unsorted Array",
                      "Unsorted LinkedList", "Binary Search Tree"),
        text.col = 2:6, cex = 0.8)


# find
time_find_SA = c(0.073087, 0.090074, 0.111407, 0.15842, 0.103506)
time_find_SLL = c(0.116543, 0.233086, 1.447112, 6.332842, 28.44169)
time_find_UA = c(0.097185, 1.18558, 2.270421, 7.259657, 11.743214)
time_find_ULL = c(0.063605, 0.657383, 2.376298, 5.357039, 12.728499)
time_find_BST = c(0.099951, 0.105877, 0.197136, 0.143803, 0.172247)
yrange_find = range(time_find_SLL)
plot(xrange, yrange_find, type = "n", xlab = "number of elements in dictionary", 
     ylab = "Operation Time(ms)")
title("find()")
lines(size, time_find_SA, type = "b", lwd = 1.5, col = 2)
lines(size, time_find_SLL, type = "b", lwd = 1.5, col = 3)
lines(size, time_find_UA, type = "b", lwd = 1.5, col = 4)
lines(size, time_find_ULL, type = "b", lwd = 1.5, col = 5)
lines(size, time_find_BST, type = "b", lwd = 1.5, col = 6)
legend("topleft", c("Sorted Array", "Sorted Linkedlist", "Unsorted Array",
                    "Unsorted LinkedList", "Binary Search Tree"),
       text.col = 2:6, cex = 0.8)

# delete
time_del_SA = c(0.039901, 0.527802, 12.95882, 69.573559, 124.42079)
time_del_SLL = c(0.009876, 0.425087, 11.284942, 469.075149, 1776.954381)
time_del_UA = c(0.014223, 0.983704, 15.913488, 110.271253, 332.412576)
time_del_ULL = c(0.013827, 0.609581, 11.535807, 250.902223, 887.019017)
time_del_BST = c(0.077827, 0.246124, 1.859557, 8.803164, 15.153784)
yrange_del = range(time_del_ULL)
plot(xrange, yrange_del, type = "n", xlab = "number of elements to delete",
     ylab = "Operation Time(ms)")
title("delete()")
lines(size, time_del_SA, type = "b", lwd = 1.5, col = 2)
lines(size, time_del_SLL, type = "b", lwd = 1.5, col = 3)
lines(size, time_del_UA, type = "b", lwd = 1.5, col = 4)
lines(size, time_del_ULL, type = "b", lwd = 1.5, col = 5)
lines(size, time_del_BST, type = "b", lwd = 1.5, col = 6)
legend("topleft", c("Sorted Array", "Sorted Linkedlist", "Unsorted Array",
                    "Unsorted LinkedList", "Binary Search Tree"),
       text.col = 2:6, cex = 0.8)