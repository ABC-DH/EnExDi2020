# Prepare OpeNER dictionary

# Call the library (or install it if not present...)
if (!require("XML")) install.packages("XML")

data <- xmlTreeParse("OpeNER-fr-sentiment_lexicon.lmf")
entries <- xmlElementsByTagName(data$doc$children[[1]], "LexicalEntry", recursive = T)

# consider just words with sentiment (not intensifiers and shifters)
entries <- entries[1:12789]

full_lemmas <- character()
full_polarities <- character()
full_confidences <- numeric()

# main iteration on the XML file
for(entry in entries){
  lemma <- xmlChildren(entry)[[1]]
  sense <- xmlChildren(entry)[[2]]
  polarity <- xmlChildren(sense)[[3]]
  confidence <- xmlChildren(sense)[[1]]
  if(length(xmlAttrs(lemma))==0){
    full_lemmas <- c(full_lemmas, NA)
    print("no lemma")
  }
  full_lemmas <- c(full_lemmas, xmlAttrs(lemma))
  if(length(xmlAttrs(polarity))==0){
    full_polarities <- c(full_polarities, NA)
    print("no polarity")
  }
  full_polarities <- c(full_polarities, xmlAttrs(polarity))
  if(length(xmlAttrs(confidence))==0){
    full_confidences <- c(full_confidences, NA)
    print("no confidence")
  }
  full_confidences <- c(full_confidences, as.numeric(xmlAttrs(confidence)[[2]]))
}

# save as dataframe
OpeNER <- data.frame(word = full_lemmas, value = full_polarities, confidence = full_confidences, stringsAsFactors = F)

# remove NAs
OpeNER <- OpeNER[which(!is.na(OpeNER$value)),]

# convert labels to values
OpeNER <- OpeNER[-which(OpeNER$value == "neutral"),]
OpeNER$value[which(OpeNER$value == "positive")] <- 1
OpeNER$value[which(OpeNER$value == "negative")] <- -1
OpeNER$value <- as.numeric(OpeNER$value)*OpeNER$confidence # final value is calculated as sentiment*confidence
OpeNER <- OpeNER[which(!is.na(OpeNER$value)),]
OpeNER$confidence <- NULL

# aggregate multiple entries for the same word (different meanings are considered in OpeNER: here everything is reduced to a single value)
OpeNER <- aggregate(OpeNER['value'], by=OpeNER['word'], mean)

# remove numbers and multi-word expressions
OpeNER <- OpeNER[-(1:13),]
double_word <- which(grepl(pattern = " ", x = OpeNER$word))
OpeNER <- OpeNER[-double_word,]

# save all
save(OpeNER, file = "OpeNER-fr.RData")
