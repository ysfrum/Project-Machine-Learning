# Machine Learning - Fachta
<div align="justify">
  <h3>Introduction</h3>
  In this capstone project, the ML team's task is to create a model that can predict of a news article is a hoax or valid. The ML team consists of 3 members who get their respective tasks evenly but are not restricted from doing expansions which is useful to add value and improve team performance and better results.
</div>

### Workflow of ML Team
#### Search for datasets and Preprocessing
Team ML firstly searched for a csv format dataset containing a collection of news articles with labels hoax and valid. The raw data we obtained came from mendeley data which can be found through this [link](https://data.mendeley.com/datasets/p3hfgr5j3m/1). Then the ML team has changed by balancing the raw data and cleaning it first so that it is easier to process. Further preprocessing is shown below:
  
   1. Defines `stopwords_list` a list of common stopwords in Bahasa Indonesia that will be removed from the text.
      ```
      stopwords_list = ["yang", "di", "dan", "ini", "dari", "itu", "dengan", "tersebut", "dalam", "untuk", "ada", "pada", "juga", "akan"]
      ```
   2. The `text_clean` function is useful for cleaning the input text from unnecessary things such as punctuation marks, non-alphanumeric characters, URLs, and others.
      ```
      def text_clean(text):
          text = ' '.join(re.sub("(@[A-Za-z0-9]+)|([^0-9A-Za-z \t])|(\w+:\/\/\S+)", " ", text).split())
          punkt = set(string.punctuation)
          text = ''.join([ch for ch in text if ch not in punkt])
          text = text.lower()
          text = re.sub('\[.*?\]', '', text)
          text = re.sub("\\W", " ", text)
          text = re.sub('https?://\S+|www\.\S+', '', text)
          text = re.sub('<.*?>+', '', text)
          text = re.sub('[%s]' % re.escape(string.punctuation), '', text)
          text = re.sub('\n', '', text)
          text = re.sub('\w*\d\w*', '', text)
          return text
      ```
  3. Perform `remove_stopwords` to separate the text into individual words, filter out words that are not in the stopwords list, and merge the remaining words into a single string.
     ```
     def remove_stopwords(text, stopwords):
         words = text.split()
         filtered_words = [word for word in words if word.lower() not in stopwords]
         return ' '.join(filtered_words)
     ```
  4. Using `lemmatizer` for accuracy and preservation of the essential meaning of each word in the text.
     ```
     def lemmatize(text):
         return [lemmatizer.lemmatize(word) for word in text.split()]
     ``` 
  6. Combine all the preprocessing functions that have been created into one `preprocess_text` function to be applied to the final data.
     ```
     def preprocess_text(text, stopwords, tokenizer):
         text = text_clean(text)
         text = remove_stopwords(text, stopwords)
         text = ' '.join(lemmatize(text))
         return sequences
    df_data['berita'] = df_data['berita'].apply(text_clean)
    df_data['berita'] = df_data['berita'].apply(lambda x: remove_stopwords(x, stopwords_list))
    df_data['berita'] = df_data['berita'].apply(lambda x: ' '.join(lemmatize(x)))  
    
#### Tokenization, padding, and split the data into training and testing data.
<div align="justify">
  After all the preprocessing steps were sufficient, the ML team continued the tasks by tokenizing and using the `fit_on_texts` method to create a word index based on the text in the `berita` column of the `df_data` DataFrame. This tokeniser will map each unique word to a number and `texts_to_sequences` to convert the text in the news column into a list of sequences, where each number represents a particular word from the original text. Padding is applied to ensure all sequences have the same length. Finally in this process, data splitting is done with a proportion of 80$ as training data and 20% as testing.
</div>

```
tokenizer = Tokenizer()
tokenizer.fit_on_texts(df_data['berita'])
sequences = tokenizer.texts_to_sequences(df_data['berita'])
```
```
max_len = max(len(seq) for seq in sequences)
X = pad_sequences(sequences, padding='post', maxlen=max_len)
y = df_data['tagging'].astype(int)
```
```
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.20, random_state=0)
```
#### Create the LSTM Model.
