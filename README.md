# MHC-GENO
This R code is intended for aiding in the genotyping of highly variable genomic regions such as the Major Histocompatibility Complex.

The input can be one or multiple .fastq files. 
The final output is a per-sample file containing all the unique sequences along with their relative frequency and length in bp. 
The primers can be trimmed and user can indicate the frequency threshold to filter variants.

For example, let us imagine we sequenced a howler monkey individual at highly-polymorphic loci MHC-DRB exon 2 producing a .fastq file with 10,000 reads (or sequences).
This file contains 20 unique sequences, from which two sequences represent 90% of all sequences (45% percent each) and one sequence is represented at 5%. 
The above means that from the 10,000 sequences: 4,500 are sequence one, 4,500 sequences are sequence two, 500 sequences are sequence three and the remaining sequences are divided among the other 17 unique sequences.
If we set our threshold at 5%, the final output will only contain three sequences (sequence one, two and three). 
This is a good way to get rid of singletons. The output file would look like this:
```
>seq1_S188_A._pigra drb_exon2 Number_reads=4500 Total_percent=0.45 Length(bp)=188
TCTTACGGTCCCTCTGGCCAGTTCACCCATGAATTTGATGGAGACGAGGAGTTCTACGTGGACCTAGGGAAAAAGGAGACTGTCTGGCGATTGCCTGTGTTCAGCACATTTACAAGTTTTGACCCACAGGGCGCACTGACAAACATCGCTGTGACAAAACACAACTTGGACGTCCTGATTAAACGCTC
>seq2_S188_A._pigra drb_exon2  Number_reads=4500 Total_percent=0.45 Length(bp)=188
TCTTACGGTCCCTCTGGCCAGTTCACCCATGAATTTGATGGAGACGAGGAGTTCTACGTGGACCTAGGGAAAAAGGAGACTGTCTGGCGATTGCCTGTGTTCAGCACATTTACAAGTTTTGACCCGCAGGGCGCACTGACAAACATCGCTGTGACAAAACACAACTTGGACATCCTGATTAAACGCTC
>seq3_S188_A._pigra (3)_ drb_exon2 Number_reads=500 Total_percent=0.45 Length(bp)=188
TCTTACGGTCCCTCTGGCCAGTTCACCCATGAATTTGATGGAGATGAGGAGTTCTACGTGGACCTAGGGAAAAAGGAGACTGTCTGGCGATTGCCTGTGTTCAGCAAATTTACAAGTTTTGACCCGCAGGGCGCACTGACAAACATCGCTGTGGCAAAATACAACTTGGACATCCTGATTACACGCTC
```

Disclaimer: I have only used this code for .fastq files produced by Illumina MiSeq sequencing which is intended for small sequences. 
            For this type of sequencing it works pretty quickly even locally.
