#### PLOT MDS ####

# This command reads the distance matrix from PLINK
Dist <- as.matrix(read.table("datasetPCA_full.dist")) / (2*num_SNPs)

# num_SNPs will be equivalent to the number of SNPs you have in your file. We calculated that in the terminal with wc -l datasetPCA_full.bim 
num_SNPs<-322218

# Let's output the results to a PDF file. You may want to first run without this option and if you're happt with the results, you can print the output to a PDF file with this command.
pdf("MDS.pdf")

# This will rescale the distance matrix to 0 to 1 values, according to the number of SNPs that you used in your analysis.
res <- cmdscale(Dist, k = nrow(Dist)-1, eig = T, add = T)

# This will transform the object above in a dataframe called "points". This is the distance matrix. 
points <- as.data.frame(res$points)

# Read the text file with the individual names.
indivs<-scan("individuals.txt",character())

# Add the individual names to the points dataframe (the distance matrix) and use "Samples" as the name of that column.
points["Sample"] <- indivs 

# Read the text file with the information on the individual, population, and point type and color. 
popGroups=read.table("ind_pop_MDS.tab", col.names=c("Sample", "Population","Color","Point"))

# Merge the distance matrix with the information in ind_pop_MDS.tab. Match both dataframes by the column Sample
mergedDF = merge(points, popGroups, by="Sample")

# Now it's time to plot!
plot(mergedDF$V1, mergedDF$V2, col=mergedDF$Color, pch=mergedDF$Point)

# Add legend.
legend("bottomright", legend=c("YRI","CEU","CHB","PER","SH", "NC","NC_lc"), col=c("yellow","darkorchid1","green","black","red", "blue","dodgerblue4"),pch=19)

dev.off()