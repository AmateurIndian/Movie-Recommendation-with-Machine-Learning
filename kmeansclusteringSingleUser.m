user = 1;
path = './Dataset/movieData.txt';

movieMat = getMovieInfo(path);
ratings = load('./Dataset/u.data');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
fileMovies = fopen('./Dataset/u.item');
genreMat = getMainGenre('./Dataset/u.item');


values(1,user) = user;
movieIndex = find(ratings(:,1) == user);


counter = 1;
for i = 1:length(movieIndex)
    movieId = ratings(movieIndex(i), 2);                                                            
    movieRating = ratings(movieIndex(i), 3);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    mainGenre = genreMat(movieId, 2);
    if mainGenre > 0
        info = movieMat{movieId, 3};
        if info ~= 'F'
            duration = str2num(char(info));
            if length(duration) > 0
                data(counter,1) = mainGenre;
                data(counter,2) = duration;
                data(counter,3) = movieRating;
                counter = counter + 1;
            end
        end  
    end
end

X = data(:,1:2);


opts = statset('Display','final');
[idx,C] = kmeans(X,5,'Distance','cityblock',...
    'Replicates',5,'Options',opts);


rmse1 = getNaiveBayesRMSE(1, idx, data);
rmse2 = getNaiveBayesRMSE(2,idx,data);
rmse3 = getNaiveBayesRMSE(3,idx,data);
rmse4 = getNaiveBayesRMSE(4,idx,data);
rmse5 = getNaiveBayesRMSE(5,idx,data);
avgRMSE = (rmse1 + rmse2 + rmse3 + rmse4 + rmse5)/5;

fprintf('RMSE for user%d is: %f',user,avgRMSE);

figure;
scatter(X(idx==1,1),X(idx==1,2),15,'r','filled')
hold on
scatter(X(idx==2,1),X(idx==2,2),15,'b','filled')
scatter(X(idx==3,1),X(idx==3,2),15,'g','filled')
scatter(X(idx==4,1),X(idx==4,2),15,'c','filled')
scatter(X(idx==5,1),X(idx==5,2),15,'y','filled')
scatter(C(:,1),C(:,2),12,'k','LineWidth',3)
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Centroids',...
       'Location','NE')
title 'Movie Clustering'
xlabel 'Genre Codes';
ylabel 'Duration (min)';
hold off
