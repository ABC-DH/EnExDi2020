library(XML)
library(stylo)

### If we want to run the analysis only on the lines of the play
### ...we can use XPath:

### first, we need to be in the right folder
### there are many ways: one is to open the menu "Session" -> "Set working directory" -> "Choose directory" (and then find the directory ".../EnExDi2020/data") 

### then, select all files in the "corpus" folder
plays_list <- list.files("corpus", full.names = T)
plays_list
### prepare an empty list for the texts 
plays_text <- list()
### and run a loop on all the files
for(i in 1:length(plays_list)){
  # read xml (through the XML package)
  data <- xmlParse(plays_list[i])
  # save the texts (only the dialogues) inside the list
  plays_text[[i]] <- xpathSApply(data,"//l",xmlValue)
  # print progress
  print(i)
}

### see part of what we generated
head(plays_text[[1]])
tail(plays_text[[1]])
head(plays_text[[2]])
tail(plays_text[[2]])

### plays were saved line by line: collapse each text in a single string
plays_text <- lapply(plays_text, function(x) paste(x, collapse = " "))

### explore
head(plays_text[[1]])
# Note: now the "head" function does not work anymore, because the text is saved on a single line
head(plays_text[[1]]) == plays_text[[1]]

### If we want to run stylo on the texts now saved in the list, we need to "tokenize" them
### i.e. split them into single words
### There is a function in the "stylo" package that does it,
### so we call it in a loop on the list that contains the texts
for(i in 1:length(plays_text)){
  # prepare each text for stylo analysis
  plays_text[[i]] <- stylo::txt.to.words.ext(plays_text[[i]], language = "French")
  print(i)
}

### explore
head(plays_text[[1]])
head(plays_text[[2]])
length(plays_text[[1]])
length(plays_text[[2]])

### we can also see the length (in words) of each text in the list
lapply(plays_text, length)

### Finally, we give to each text in the list the name that it had in the "corpus" folder
names(plays_text) <- list.files("corpus")
# check the names:
names(plays_text)

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
