#MHC-GENO-stats

#Before starting
#Install package and library (stringr)
#If working with multiple files, I recommend naming the files with a pattern that is easy to...
#...iterate through (e.g., drb_exon2_1.fastq, drb_exon2_2.fastq... drb_exon2_N.fastq)


#MHC-GENO_stats
#For the following code we will assume we are working with 96 samples named drb_exon2_1.fastq to drb_exon2_96.fastq


#First,create a list of files based on the files you want to access
lista_arch_dqa<-list.files(pattern="^drb_exon2_")

#Second, we create several empty lists that will be filled during the for loop iteration
lista_inicial<-list()#This list contains the files to read
uno_per<-list()#this list stores a value the threshold value
lista_soloseq<-list()#this list stores the sequences from each sample that are unique
lista_seqfreq<-list()#this list stores the unique sequences that are represented more than threshold value
lista_noprim<-list()#this list stores the sequences without primers

#Third, run the for loop to produce the MHC-GENO-stats output files


for (i in 1:96)
{
  lista_inicial[[i]]<-read.table(paste("drb_exon2_",i,".fastq",sep=""), quote = "", sep = "\t", row.names = NULL, header = FALSE, stringsAsFactors=FALSE)
  uno_per[[i]]<-((nrow(lista_inicial[[i]]))/4)*.01
  lista_soloseq[[i]]<-as.data.frame( table(lista_inicial[[i]][seq(2,nrow(lista_inicial[[i]]), 4), ]), row.names = NULL)
  lista_seqfreq[[i]]<- lista_soloseq[[i]][lista_soloseq[[i]]$Freq > uno_per[[i]],]
  lista_noprim[[i]]<-sub(".*GTGCTGCAGGTGTAAACTTGTACCAG *(.*?) *CAACTCTACCGCTGCTACCGGATCCGTG*", "\\1", lista_seqfreq[[i]]$Var1)
  lista_seqfreq[[i]]$Var1<-lista_noprim[[i]]
  lista_seqfreq[[i]]$Percent<-lista_seqfreq[[i]]$Freq/((nrow(lista_inicial[[i]]))/4)
  write.table(lista_seqfreq[[i]], (paste("seqdqa_exon2_",i,".txt",sep = "")), sep="\t", quote=FALSE, row.names = FALSE)
}

#line28: reads files based on the name pattern, this has to be adjusted according to the names of the samples used.
#line29:creates a list that contains a value of 1% of total number of sequences. This value can be adjusted. 
#       For example if we want a 5% threshold we can change the ".01" to ".05"
#line30:Creates a data frame, it is important to put first "as.data.frame" as these adds colums.
#       The table function gives you a data frame with the frequency of apperances,
#		    here I indicate only to keep the second row of every 4 rows (that contains the sequence).
#line31: Creates a list in which only the sequences that a repetated more than 1% of the total sequences are kept
#line32: Creates a list of the sequences without the forward primer and the reverse complement
#		     of the reverse primer, this list will substitute the column, that contains the sequence,in the original file.
#		     Forward primer= GTGCTGCAGGTGTAAACTTGTACCAG, Reverse complement of reverse primer=CAACTCTACCGCTGCTACCGGATCCGTG
#		     In this line you can substitute for your own primers. Even if you are working with degenrate primers
#		     You can substitute the degenerate base for [:alpha:]
#line33: Substitutes the column of the sequence with the primers with a new column with sequences with no primers
#line34: Creates a new column that will give the percent value for each sequence based on all the sequences
#line35: Writes the file name. Keep in mind that for this step we are using the same iteration value (i)
#		     that we are using to read the files so we can maintain consistency.
#Now we use these newly created files in the MHC-GENO-final code.
