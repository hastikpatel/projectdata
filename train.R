library(randomForest)
library(jsonlite)

df <- read.csv("./winequality-red.csv", h=T, sep = ";")
df$quality <- factor(df$quality)

cols <- names(df)[1:11]
system.time({
  clf <- randomForest(df$quality ~ ., data=df[,cols], ntree=30, nodesize=4, mtry=8)
})
# comment 

plot(clf)

save(clf, file="classifier.Rda")
save(cols, file="cols.Rda")


diagnostics = list("err" = mean(clf$err.rate), "ntree" = clf$ntree)
fileConn<-file("dominostats.json")
writeLines(toJSON(diagnostics), fileConn)
close(fileConn)


