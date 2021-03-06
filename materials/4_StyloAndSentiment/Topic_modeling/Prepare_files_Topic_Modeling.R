library(stylo)

### Define variables
len_split <- 1000 # length of the split texts
no_topics <- 25 # number of topics
counter <- 100 # used to generate labels: to increase if the number of topics is more than 100

### remove the result of previous processes
file.remove("topic_modeling_corpus.txt")

### Prepare the corpus
tm_corpus <- list()
plays_list <- list.files("corpus", full.names = T)

for(i in 1:length(plays_list)){
  
  # read xml (with stylo's function)
  loaded_file <- scan(plays_list[i], what = "char", encoding = "utf-8", sep = "\n", quiet = TRUE)
  # save the texts (without markup) inside a provisional variable
  tm_corpus[[i]] <- stylo::delete.markup(loaded_file, markup.type = "xml.drama")
  
  # define a new title for the output text
  new_title <- gsub(pattern = "corpus/|.xml", replacement = "", x = plays_list[i])
  names(tm_corpus)[i] <- new_title
  
  # print progress
  print(i)
  
}

### Main loop to generate final files
all_labels <- character()
for(i in 1:length(tm_corpus)){
  text_tmp <- tm_corpus[[i]]
  tokenized_text <- unlist(strsplit(text_tmp, "\\W"))
  tokenized_text <- tokenized_text[-which(tokenized_text=="")]
  len_limit <- length(tokenized_text)
  print(len_limit)
  split_dim <- trunc(len_limit/len_split)
  tokenized_text_split <- split(tokenized_text, ceiling(seq_along(tokenized_text)/len_split))
  tokenized_text_split <- tokenized_text_split[-length(tokenized_text_split)]
  tokenized_text_split <- unlist(lapply(tokenized_text_split, function(x) paste(x, collapse = " ")))
  for(n in 1:length(tokenized_text_split)){
    cat(counter, "\t", paste(names(tm_corpus)[i], n, sep = "_"), "\t", tolower(tokenized_text_split[n]), "\n", file = "topic_modeling_corpus.txt", append = T, sep = "")
    all_labels[counter] <- paste(names(tm_corpus)[i], n, sep = "_")
    counter <- counter+1
  }
}
all_labels <- all_labels[-which(is.na(all_labels))]

### Write accompanying files (useful for visualizations in Gephi)
Id <- c(0:(no_topics-1),100:(counter-1))
Label <- c(paste("Topic", 0:(no_topics-1), sep = "_"), all_labels)
group <- strsplit(Label, split = "_")
group <- unlist(lapply(group, function(x) x[1]))
labels_df <- data.frame(Id, Label, group, stringsAsFactors = F)
dir.create("gephi_files")
write.csv(labels_df, file = "gephi_files/gephi_nodes.csv",row.names = F)
