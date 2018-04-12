# read "sms_spam.csv" file, 
# we must add encoding='UTF-8'otherwise we can't use DocumentTermMatrix funciton later
sms_raw <- read.csv("sms_spam.csv", stringsAsFactors = FALSE,encoding='UTF-8')

# rename
names(sms_raw)[1] <- 'type'

# check the variables
str(sms_raw$type)
table(sms_raw$type)

# change spam and ham to factor
sms_raw$type <- factor(sms_raw$type)

# import text mining package "tm"
library(tm)

# build a Volatiel Corpora containing the SMS messages in the training data
sms_corpus <- VCorpus(VectorSource(sms_raw$text))

# check corpora
print(sms_corpus)
inspect(sms_corpus[1:3])
view1[[1]]$content
view1[[2]]$content
view1[[3]]$content
# we can also use as.character(sms_corpus[[1]]) to check the content
as.character(sms_corpus[[1]])
# and also can use lapply(sms_corpus[1:3], as.character) to check the content
lapply(sms_corpus[1:3], as.character)

# convert all of the SMS messages to lowercase and remove any numbers:
sms_corpus_clean <- tm_map(sms_corpus, content_transformer(tolower))
sms_corpus_clean <- tm_map(sms_corpus_clean, removeNumbers)

# delete stop words 
sms_corpus_clean <- tm_map(sms_corpus_clean, removeWords, stopwords())

# define replace function
# replacePunctuation <- function(x) { gsub("[[:punct:]]+", " ", x) }

# remove punctuation
sms_corpus_clean <- tm_map(sms_corpus_clean, removePunctuation)

# install SnowballC package, which can handle same word with different type
library(SnowballC)
wordStem(c("learn", "learned", "learning", "learns"))

# make different words' type to single one
sms_corpus_clean <- tm_map(sms_corpus_clean, stemDocument)

# remove additional whitespace, leave a single one
sms_corpus_clean <- tm_map(sms_corpus_clean, stripWhitespace)


# create a sparse matrix
sms_dtm <- DocumentTermMatrix(sms_corpus_clean)

# create train set and test set
sms_dtm_train <- sms_dtm[1:4169, ]
sms_dtm_test  <- sms_dtm[4170:5559, ]

# keep classical label
sms_train_labels <- sms_raw[1:4169, ]$type
sms_test_labels  <- sms_raw[4170:5559, ]$type

# word cloud
library(wordcloud)
# wordcloud example, input 26 letters, the frequency is 1 to 26 according to a to z.
# wordcloud(c(letters), seq(1, 26),random.order=F)
# wordcloud example, show three words which the most frequency
# wordcloud(iris$Species, max.words=3)

# wordcloud can support corpus type. a word appear more than 50 times can be showed in cloud
wordcloud(sms_corpus_clean, min.freq = 50, random.order = FALSE)

# make the train set into two sets, discovery the word cloud
spam <- subset(sms_raw, type == "spam")
ham  <- subset(sms_raw, type == "ham")
# the typeface is 0.5 to 3
wordcloud(spam$text, max.words = 40, scale = c(3, 0.5))
wordcloud(ham$text, max.words = 40, scale = c(3, 0.5))

# find and save these words which frequency greater than 5
sms_freq_words <- findFreqTerms(sms_dtm_train, 5)

# use the high frequency words to build a new sparse matrix
sms_dtm_freq_train <- sms_dtm_train[ , sms_freq_words]
sms_dtm_freq_test <- sms_dtm_test[ , sms_freq_words]

# change frequency to "yes" and "no"
convert_counts <- function(x) {
  x <- ifelse(x > 0, "Yes", "No")
}

# make the change, margin=2 means use for columns
sms_train <- apply(sms_dtm_freq_train, MARGIN = 2, convert_counts)
sms_test  <- apply(sms_dtm_freq_test, MARGIN = 2, convert_counts)


# use e1071 package to do naive byes analyzation
library(e1071)
sms_classifier <- naiveBayes(sms_train, sms_train_labels)

# evaluate the performance
sms_test_pred <- predict(sms_classifier, sms_test)

# use crosstable to show the performance
library(gmodels)
CrossTable(sms_test_pred, sms_test_labels,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))

# boost property
sms_classifier2 <- naiveBayes(sms_train, sms_train_labels, laplace = 1)
sms_test_pred2 <- predict(sms_classifier2, sms_test)
CrossTable(sms_test_pred2, sms_test_labels,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))





