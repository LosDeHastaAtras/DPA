
# Get the files names
files <- list.files(pattern="*.csv")

# First apply read.csv, then rbind
myfiles <- do.call(rbind, lapply(files, function(x) read.csv(x, sep=",", skip=1, header=FALSE, stringsAsFactors = FALSE)))
head(myfiles)

a<-read.csv("2010-02.csv", sep=",",stringsAsFactors = FALSE)
names(a)
nombres<-names(a)
colnames(myfiles)<-nombres
names(myfiles)
head(myfiles)
saveRDS(myfiles,file="ecobici_all.RDS")
