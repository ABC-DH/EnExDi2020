### Lemmatization of a text using UDpipe

# Call the library (or install it if not present...)
if (!require("udpipe")) install.packages("udpipe")
library(stylo)

# first, download the model for French language
udpipe::udpipe_download_model(language = "french")

# then upload it to an R variable
udmodel_french <- udpipe_load_model(file = "french-gsd-ud-2.4-190531.udpipe")

# find the files in the "corpus" folder
# REMEMBER that you have to be in the correct working directory (which contains "corpus")
plays_list <- list.files("corpus", full.names = T)

# create a new folder to save the lemmatized texts
dir.create("texts_fr")

# run a loop on all the xml files
# CAREFUL: it might take a while
for(i in 1:length(plays_list)){
  
  # print progress
  print(i)
  
  # read xml (with stylo's function)
  loaded_file <- scan(plays_list[i], what = "char", encoding = "utf-8", sep = "\n", quiet = TRUE)
  # save the texts (without markup) inside a provisional variable
  plays_text <- stylo::delete.markup(loaded_file, markup.type = "xml.drama")
  
  # print progress
  print("Text uploaded")
  
  # annotate the text using udpipe
  x <- udpipe_annotate(udmodel_french, x = plays_text)
  x <- as.data.frame(x)
  # print progress
  print("Text annotated")
  
  # define a new title for the output text
  new_title <- paste("texts_fr/", gsub(pattern = "corpus/", replacement = "", x = plays_list[i]), sep = "")
  new_title <- gsub(".xml", ".txt", new_title)
  
  # save the lemmatized text (sentence by sentence)
  cat(x$lemma[1], "", file = new_title)
  for(i in 2:length(x$token_id)){
    if(x$sentence_id[i] != x$sentence_id[i-1])
      cat("\n", file = new_title, append = T)
    if(is.na(x$lemma[i]))
      next
    cat(x$lemma[i], "", file = new_title, append = T)
  }

  # print progress
  print("Text saved")

}
