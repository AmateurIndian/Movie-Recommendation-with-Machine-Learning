# Movie-Recommendation-with-Machine-Learning

The project is aimed at comparing various algorithmic implementations in attempting to predict the ratings a certain user 
would give to a certain movie. There there are 2 approaches, that is taken which broadly encompesses the various algorithms. 
The first approach is Content Based recommendations and the other is Collaborative Filtering. 

Algorithms Used:
User-User Recomendation
Item-Item Recomendation
Naive Bayes
K-Means Clustering
Kernel K-Means

Project also aims at checking correlation between user age and user occupation, and the ratings that these sample users would 
give to a movie.

Dataset
The dataset obtained was from MovieLens and was collected by the GroupLens Research Project at the University of Minnesota. 
There are various sizes of datasets available ranging from 100K to 10M entries. The project utilizes only the 100k dataset 
and 1M which has specifications as follows:

* Each user has rated at least 20 movies. 
* Simple demographic info for the users (age, gender, occupation)
* Movie information regarding genre and release date

Additional information about movies is also gotten from IMDB using IMDBPy which at the moment includes the following 
information:

Top 5 main cast members
Director
Duration of movie
Top 2 producers
Production House
Country in which produced
Language
Distribution Company

Both datasets, the 100K and 1M are both divided into subsets of data, where 80% of the data is the training set whereas 20% 
of the data is the test set of data, and these sets are non-overlapping. 
