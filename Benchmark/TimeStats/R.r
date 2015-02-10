library(ggplot2)
# header = TRUE ignores the first line, check.names = FALSE allows '+' in 'C++'
benchmark <- read.table("file_final", header = TRUE, row.names = "Title", check.names = FALSE)
# 't()' is matrix tranposition, 'beside = TRUE' separates the benchmarks, 'heat' provides nice colors
jpeg('rplot.jpg')
barplot(t(as.matrix(benchmark)), beside = TRUE, col = heat.colors(4))
# 'cex' stands for 'character expansion', 'bty' for 'box type' (we don't want borders)
legend("topleft", names(benchmark), cex = 0.9, bty = "n", fill = heat.colors(4))
dev.off()
