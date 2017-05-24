% user = 1;
% path = './Dataset/movieData.txt';

% movieMat = getMovieInfo(path);
% ratings = load('./Dataset/u.data');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
% fileMovies = fopen('./Dataset/u.item');
% movieIndex = find(ratings(:,1) == user);
% genreMat = getMainGenre('./Dataset/u.item');
% testMovie(1,1) = 1;
% testMovie(1,2) = 1;
% counter = 1;
% for i = 1:length(movieIndex)
%     movieId = ratings(movieIndex(i), 2);                                                            
%     movieRating = ratings(movieIndex(i), 3);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
%     mainGenre = genreMat(movieId, 2);
%     if mainGenre > 0
%         info = movieMat{movieId, 3};
%         if info ~= 'F'
%             duration = str2num(char(info));
%             if length(duration) > 0
%                 data(counter,1) = mainGenre;
%                 if duration > 200
%                     data(counter,2) = 7;
%                 elseif duration > 180
%                      data(counter,2) = 6;
%                 elseif duration > 150
%                     data(counter, 2) = 5;
%                 elseif duration > 120
%                     data(counter, 2) = 4;
%                 elseif duration > 90
%                     data(counter, 2) = 3;
%                 elseif duration > 60
%                     data(counter, 2) = 2;
%                 else
%                     data(counter, 2) = 1;
%                 end  
%                 data(counter,3) = movieRating;
%                 counter = counter + 1;
%             end
%         end  
%     end
% end
for userID = 1:943
    values(1,userID) = userID;
    data = loadDataNaiveBayes('./Dataset/movieData.txt','./Dataset/u.item','./Dataset/u1.base', userID);
    testData = loadDataNaiveBayes('./Dataset/movieData.txt','./Dataset/u.item','./Dataset/u1.test', userID);
    if testData ~= -1
        X = data(:,1:2);
        Y = data(:,3);

        genreArr = ones(20,5);
        durationArr = ones(7,5);
        ratingsArr = ones(1,5);

        for i = 1:length(ratingsArr)
            ratingsArr(1,i) = sum(Y(:) == i);
        end

        for i = 1:length(durationArr)
           for j = 1:length(ratingsArr)
                durationArr(i,j) = sum(((data(:,2) == i) & (data(:,3) == j)));
           end
        end

        for i = 1:length(genreArr)
           for j = 1:length(ratingsArr)
                genreArr(i,j) = sum(((data(:,2) == i) & (data(:,3) == j)));
           end
        end

        for i = 1:5
            genreArr(:,i) = genreArr(:,i)/sum(genreArr(:,i));
            durationArr(:,i) = durationArr(:,i)/sum(durationArr(:,i));
        end

        totRatings = sum(ratingsArr);

        for i = 1:length(ratingsArr)
            prior(i) = ratingsArr(i)/totRatings;
        end

        genreArr(genreArr == 0) = 1;
        durationArr(durationArr == 0) = 1;


        Xtest = testData(:,1:2);
        Ytest = testData(:,3);
        rmseSum = 0;
        for i = 1:length(Ytest)

            for j = 1:5
                lhMat(1,j) = log10(genreArr(Xtest(i,1),j)) + log10(durationArr(Xtest(i,2),j)) + log10(prior(j));
            end
            [ratingFound(i,1), ratingFound(i,2)] = max(lhMat);
            rmseSum = rmseSum + (ratingFound(i,2) - Ytest(i))*(ratingFound(i,2) - Ytest(i));
        end

         values(2,userID) = sqrt(rmseSum/length(Ytest));
    end
end
    

%confusionMat = fitcnb(X,Y,'ClassNames',{'1','2','3','4','5'});

% opts = statset('Display','final');
% [idx,C] = kmeans(X,5,'Distance','sqeuclidean',...
%     'Replicates',5,'Options',opts);
% 
% % cluster1 = find(idx == 1);
% % val1 = 0;
% % 
% % for i = 1:length(cluster1)
% %     val1 = val1 + data(cluster1(i), 3);
% % end
% % mean1 = val1/length(cluster1);
% % errNum = 0;
% % for i = 1:length(cluster1)
% %     errNum = errNum + (mean1-data(cluster1(i),3))*(mean1-data(cluster1(i),3));
% % end
%     rmse1 = getNaiveBayesRMSE(1, idx, data);
%     rmse2 = getNaiveBayesRMSE(2,idx,data);
%     rmse3 = getNaiveBayesRMSE(3,idx,data);
%     rmse4 = getNaiveBayesRMSE(4,idx,data);
%     rmse5 = getNaiveBayesRMSE(5,idx,data);
%     avgRMSE = (rmse1 + rmse2 + rmse3 + rmse4 + rmse5)/5
% 
% figure;
% plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
% hold on
% plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
% plot(X(idx==3,1),X(idx==3,2),'g.','MarkerSize',12)
% plot(X(idx==4,1),X(idx==4,2),'k.','MarkerSize',12)
% plot(X(idx==5,1),X(idx==5,2),'y.','MarkerSize',12)
% plot(C(:,1),C(:,2),'kx',...
%      'MarkerSize',15,'LineWidth',3)
% legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Centroids',...
%        'Location','NE')
% title 'Movie Clustering'
% xlabel 'Genre Codes';
% ylabel 'Duration (min)';
% hold off