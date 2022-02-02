# You may have installed these packages before. If so, you don't need to install them again.
install.packages("usethis")
install.packages('devtools',dependencies=T)
install_github('royfrancis/pophelper')

# In any case you will need to load the libraries with these commands:
library(usethis)
library(devtools)
library(pophelper)

#Load ID and pop label
inds <- read.table('./ind_pop.admix.tab',header=FALSE,stringsAsFactors=F) 

pops <- data.frame(Pop=inds[,2], stringsAsFactors = F)                
inds <- inds[,1]

#create a folder with all unsupervised outputs
afiles<- list.files('./unsupervised_out', full.names=T)
alist <- readQ(files=afiles) #import Q files

# if all runs are equal length, add ind label to all runs
if(length(unique(sapply(alist,nrow)))==1) alist <- lapply(alist,"rownames<-",inds)

# show row names of all runs and all samples
lapply(alist, rownames)

#Plot all K with all populations
#imgoutput='join' - plots in one pdf
#imgoutput='sep' - plot in separate files

plotQ(alist,imgtype = 'pdf' , imgoutput="join" ,showsp = T , showtitle = F, divsize = 0 ,linealpha = 0,
      pointalpha = 0,returnplot=F, exportplot=T, basesize=5, panelratio=c(5,1),
      grplab=pops,grplabsize=0.7,grplabangle = 90, grplabpos=1, grplabheight = 1,
      ordergrp=TRUE, width = 40,clustercol = c(rainbow(10)), exportpath=getwd()
)


