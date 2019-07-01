from nltk.tokenize import sent_tokenize, word_tokenize
import warnings

warnings.filterwarnings(action='ignore')

import gensim
from gensim.models import Word2Vec

sample = open("C:\\Users\\terry\\Desktop\\alice.txt", "r", encoding="utf8")
s = sample.read()

f = s.replace("\n", " ")

data = []

for i in sent_tokenize(f):
    temp = []

    for j in word_tokenize(i):
        temp.append(j.lower())


    data.append(temp)

model1 = gensim.models.Word2Vec(data, min_count=1, size=100, window=5)

print("cosine similarity between alice and wonderland", model1.similarity('alice', 'wonderland'))
print("cosine similarity between dog and cat", model1.similarity('dog', 'cat'))