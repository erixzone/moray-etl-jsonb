
objects <- read.table("object.txt", stringsAsFactors = FALSE, header = FALSE)
measures <- read.csv("table.csv", stringsAsFactors = FALSE, header = TRUE)
cnames <- names(measures)
measures <- cbind(measures, (measures$D / (measures$D + measures$M)))
cnames <- names(measures) <- c(cnames, "Sp")
measures <- cbind(measures, (measures$U / measures$D))
cnames <- names(measures) <- c(cnames, "Cx")
measures <- cbind(measures, (log2(measures$B) + log2(measures$Sp) + log2(measures$Cx)))
cnames <- names(measures) <- c(cnames, "Q")
Fs <- 0.15
m_table <- measures$name[measures$Q > 0]
m_table <- c(m_table,objects[,1])
m_table <- unique(m_table)
r_table <- measures$name[(measures$Q < 0) & (measures$Sp > Fs)]
r_table <- r_table[!(r_table %in% objects[,1])]
s_table <- measures$name[(measures$Q < 0) & (measures$Sp < Fs)]
r_table <- sort(r_table)
s_table <- sort(s_table)
r_tableString <- paste("    '", paste(r_table, collapse="',\n    '"), "'", sep="")
m_tableString <- paste("    '", paste(m_table, collapse="',\n    '"), "'", sep="")
s_tableString <- paste("    '", paste(s_table, collapse="',\n    '"), "'", sep="")
r_tableFile <- file("r_table.txt", "w") 
cat(r_tableString, file=r_tableFile, sep = "\n")
close(r_tableFile)
s_tableFile <- file("s_table.txt", "w") 
cat(s_tableString, file=s_tableFile, sep = "\n")
close(s_tableFile)
m_tableFile <- file("m_table.txt", "w") 
cat(m_tableString, file=m_tableFile, sep = "\n")
close(m_tableFile)
