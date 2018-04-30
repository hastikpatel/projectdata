library(randomForest)
library(jsonlite)

df <- read.csv("./winequality-red.csv", h=T, sep = ";")
df$quality <- factor(df$quality)

# add a comment

# add another comment

ntrees <- as.numeric(commandArgs(trailingOnly = T)[1])

# add a comment

cols <- names(df)[1:11]
system.time({
  clf <- randomForest(df$quality ~ ., data=df[,cols], ntree=ntrees, nodesize=4, mtry=8)
})

# note 1

plot(clf)

save(clf, file="classifier.Rda")
#save(cols, file="cols.Rda")


diagnostics = list("err" = mean(clf$err.rate), "ntree" = clf$ntree)
fileConn<-file("dominostats.json")
writeLines(toJSON(diagnostics), fileConn)
close(fileConn)


