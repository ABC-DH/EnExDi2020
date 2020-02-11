### Sentiment analysis exercises

library(syuzhet)

### 1. Simple Syuzhet analysis

### read the text
text <- readLines("texts_eng/Austen_Pride.txt")

### R reads the text line by line. To simplify Syuzhet's work, let's collapse it in a single line
text <- paste(text, collapse = " ")

### Here Syuzhet comes into action: it splits the text into sentences
sentences_vector <- get_sentences(text)

### ...and calulate the sentiment for each sentence
syuzhet_vector <- get_sentiment(sentences_vector, method="syuzhet")

### Visualize some stats
summary(syuzhet_vector)

### Visualize the graph
plot(
  syuzhet_vector, 
  type="l", 
  main="Pride and Prejudice Sentiment", 
  xlab = "Narrative Time", 
  ylab= "Emotional Valence"
)

### ...it is quite noisy!
### To have a "plot arc", we have to use a series of filters
### The easiest is "rolling mean"

# NOTE: before running the command, expand the "Plots" panel!
simple_plot(syuzhet_vector, title = "Pride and Prejudice")

### Save the plot in png
png("Austen_Syuzhet_simple_plot.png", height = 900, width = 1600, res = 100)
simple_plot(syuzhet_vector, title = "Pride and Prejudice")
dev.off()

### Save the plot in svg (vectorial graphics)
svg("Austen_Syuzhet_simple_plot.svg", height = 9, width = 16)
simple_plot(syuzhet_vector, title = "Pride and Prejudice")
dev.off()

### 2. Analysis of emotions

### Using NRC emotion lexicon
# but CAREFUL!!! It might take a bit of time...
syuzhet_emotions <- get_nrc_sentiment(sentences_vector)

# to avoid issues, we can try just a session of the novel (the first 100 sentences)
syuzhet_emotions <- get_nrc_sentiment(sentences_vector[1:100])
# some warnings might appear: in case, please ignore them...

### check the values per emotion
syuzhet_emotions$disgust
syuzhet_emotions$... # try to delete the three dots and press TAB!

### see just the beginning of the vectors
head(syuzhet_emotions$anger)
head(syuzhet_emotions$anticipation)

### Simple plot sui valori di fiducia
simple_plot(syuzhet_emotions$trust, title = "Trust in Pride and Prejudice")

### 3. Analysis of sentiment in French

### Upload the "OpeNER" dictionary (for French language)
load("OpeNER-fr.RData")
# it was downloaded from: https://github.com/opener-project/VU-sentiment-lexicon/tree/master/VUSentimentLexicon/FR-lexicon
# It was reduced to two simple components:
# word (or better, its lemma)
# and value (a simple sentiment value)

# to see how it was generated from the original file (in XML!), you can check the "OpeNER_prepare.R" file

# explore OpeNER
View(OpeNER)

### Upload the French text
French_text <- readLines("texts_fr/MOLIERE_MISANTHROPE.txt")
# here readLines comes up handy, because sentences are already split into separated lines
# please ignore warning about incomplete final line!

### Check the text
head(French_text)
# the text is lemmatized (using UDPipe)
# and already divided into sentences
# to see how lemmatization was done, check the file "Lemmatization_UDPipe.R"

### Calculate sentiment values for the text
# note: the dictionary now used is OpeNER
syuzhet_vector_French <- get_sentiment(French_text, method = "custom", lexicon = OpeNER)
summary(syuzhet_vector_French)

### Viualize the plot
my_title = "Le Misanthrope de Molière"
simple_plot(syuzhet_vector_French, title = my_title)

### Save plot in png
png("MOLIERE_MISANTHROPE_simple_plot.png", height = 900, width = 1600, res = 100)
simple_plot(syuzhet_vector_French, title = my_title)
dev.off()
