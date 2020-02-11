### 1. Delta Analysis

# call the "stylo" library
# REMEMBER that this should be done everytime you re-start R
library(stylo)

# Stylo works by default on the files in the "corpus" folder inside the working directory
# if you are not there, it will ask you to reach that folder
# HOWEVER, it is always good practice to define the working directory from the beginning
# it can be done via the menu "Session" -> "Set Working Directory" -> "Choose Working Directory"
# in the menu, you will have to browse to the folder that contains the EnExDi corpus: ".../EnExDi2020/data"

# to use stylo, write this very simple command:
stylo()
# it has a user interface, so (for simple experiments) it does not require coding

# in the first panel (Input & Language), select: "XML-plays", "French", and "Native encoding"
# Try different experiments:
# 100MFW min and max, 0 increment (features), CA with Classic and Cosine Delta (statistics)
# 2000MFW min and max, 0 increment (features), CA with Classic and Cosine Delta (statistics)
# 200-2000MFW, 200 increment (features), BCT with Classic and Cosine Delta (statistics)

# BCT Cosine Delta 20-200MFW and 200-2000MFW (interesting)
# cf. with Classic Delta...

# also, note that each analysis has generated a .csv file that can be opened with Gephi (for network analysis)

### how does the "xml.drama" upload in Stylo work?
### the following two lines of code are copy-pasted from Stylo "internal" code:
loaded_file <- scan("corpus/BOYER_AGAMEMNON.xml", what = "char", encoding = "utf-8", sep = "\n", quiet = TRUE)
stylo::delete.markup(loaded_file, markup.type = "xml.drama")
# NOTE: the markup is simply deleted :(
# if you want to see how to work by profiting of the XML encoding, please check the "XML_stylo_exercise.R" file (but you'll have to install a new package, XML)

### It can be useful to save the texts into R variables, so we can run multiple analyses on them without having to read them all the times

# First, select all files in the "corpus" folder
plays_list <- list.files("corpus", full.names = T)
plays_list
### then prepare an empty list for the texts 
plays_text <- list()
### and run a loop on all the files
for(i in 1:length(plays_list)){
  # read xml (with stylo's function)
  loaded_file <- scan(plays_list[i], what = "char", encoding = "utf-8", sep = "\n", quiet = TRUE)
  # save the texts (without markup) inside the list
  plays_text[[i]] <- stylo::delete.markup(loaded_file, markup.type = "xml.drama")
  # If we want to run stylo on the texts now saved in the list, we need to "tokenize" them (i.e. split them into single words)
  # There is a function in the "stylo" package that does it:
  plays_text[[i]] <- stylo::txt.to.words.ext(plays_text[[i]], corpus.lang = "French")
  # then add correct names to the different texts in the list
  # (we can re-use the names saved in the list_files variable, by deleting the "corpus/" at the beginning)
  names(plays_text)[i] <- gsub(pattern = "corpus/", replacement = "", x = plays_list[i])
  # print progress
  print(i)
}

# now you can explore the list: each element contains one tokenized text
names(plays_text)
head(plays_text[[1]])
head(plays_text[[2]])

### Now everything is ready to run stylo on the texts that we have saved in the R list
### We can even call stylo by deactivating the GUI, and setting all the features via R code
results_stylo <- stylo(gui = FALSE, 
      corpus.lang="French", 
      analysis.type="CA", 
      mfw.min=2000, 
      mfw.max=2000,
      distance.measure="dist.wurzburg",
      parsed.corpus = plays_text)
# Note: the results of the analysis have been saved in a variable called "stylo_results"

### Explore
results_stylo$distance.table
# Note: the "$" simbol is used to see the sub-section in a structured variable

### see the name of the texts in the distance table
rownames(results_stylo$distance.table)

### see a portion of the distance table
### for example the one of the first text in our selection
results_stylo$distance.table[1,]

### which one is the "closest" text?
sort(results_stylo$distance.table[1,])

### see a table with the frequency of all words
results_stylo$frequencies.0.culling
# rows are the texts, columns the words

### produce a list of the most frequent words
colnames(results_stylo$frequencies.0.culling)

### which is the position in the table of the word "fou"
fou_position <- which(colnames(results_stylo$frequencies.0.culling) == "fou")

### which author uses "fou" more frequently?
sort(results_stylo$frequencies.0.culling[,fou_position], decreasing = T)

### 2. Zeta Analysis

### first, find the texts written by one author (e.g. Scudery)
Chosen_texts <- which(grepl("SCUDERY", names(plays_text)))
# This is a typical example of an "embedded" R function
# the "grepl" function checks if the string "SCUDERY" is present in the names of the "plays_text" list
# the "which" function check where the "grep" function found a correspondence
Chosen_texts

### We use the "oppose" function, still in the "stylo" package,
### that looks for the most distinctive words.
### The method it uses is known as "Zeta Analysis"
### The corpus should be divided in two parts:
### A "primary set" where we have the texts of interest;
### A "secondary set" to be compared with

### Our primary set are the texts by Scudery
primary_set <- plays_text[Chosen_texts]
### Our secondary set are the texts by all the others
secondary_set <- plays_text[-Chosen_texts]

### now everything is ready to run an "oppose" analysis
oppose(primary.corpus = primary_set, secondary.corpus = secondary_set)
# in the graphical interface, you can leave things as they are
# please choose the "Words" visualization