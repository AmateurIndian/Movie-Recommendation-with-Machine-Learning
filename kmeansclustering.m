user = 1;
path = './Dataset/movieData.txt';

movieMat = getMovieInfo(path);
ratings = load('./Dataset/u.data');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
fileMovies = fopen('./Dataset/u.item');
genreMat = getMainGenre('./Dataset/u.item');

for user = 1:942
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
    
    values(2,user) = avgRMSE;
    fprintf('RMSE for user%d is: %f',user,avgRMSE);
end

scatter(values(1,:),values(2,:),15,'k','filled')
title 'Movie Clustering'
xlabel 'User Ids';
ylabel 'RMSE Values';
hold on


% % % samples = length(data);
% % % kernelMatrix = zeros(samples);
% % % gam = 0.05;
% % % for i = 1:samples
% % %     for j = 1:samples
% % %         kernelMatrix(i,j) = exp(-gam*sum((data(i,:)-data(j,:)).^2));
% % %     end
% % % end
% % % 
% % % numofClasses = 5;
% % % distMatrix = repmat([1 2 3 4 5],samples,1);
% % % distances = sum(data.^2,2);
% % % index = find(distances == min(distances));
% % % distMatrix(index,:) = [1 2 3 4 5];
% % % di = zeros(samples,numofClasses);
% % % cols = {'r','b'};
% % % 
% % % 
% % % distMatrixPrev = 0;
% % % while sum(sum(distMatrixPrev~=distMatrix))~=0
% % %     
% % %     samplesk = sum(distMatrix,1);
% % %     for k = 1:numofClasses
% % %         di(:,k) = diag(kernelMatrix) - (2/(samplesk(k)))*sum(repmat(distMatrix(:,k)',samples,1).*kernelMatrix,2) + ...
% % %             samplesk(k)^(-2)*sum(sum((distMatrix(:,k)*distMatrix(:,k)').*kernelMatrix));
% % %     end
% % %     distMatrixPrev = distMatrix;
% % %     distMatrix = (di == repmat(min(di,[],2),1,numofClasses));
% % %     distMatrix = 1.0*distMatrix;
% % %     
% % %     index1 = find(distMatrix(:,1));
% % %     index2 = find(distMatrix(:,2));
% % %     index3 = find(distMatrix(:,3));
% % %     index4 = find(distMatrix(:,4));
% % %     index5 = find(distMatrix(:,5));
% % %     duplicate = index1;
% % %     if index1(:,1) == index2(:,1)
% % %         maxIn = length(index1)-1;
% % %         index1 = index1(1:37,1);
% % %         index2 = index2(38:73,1);
% % %         index4 = index4(74:maxIn,1);
% % %     end
% % %     
% % %     scatter(data(index4,1),data(index4,2),30, 'r','filled');
% % %     hold on;
% % %     scatter(data(index5,1),data(index5,2),30, 'y','filled');    
% % %     scatter(data(index2,1),data(index2,2),30, 'b','filled');
% % %     scatter(data(index3,1),data(index3,2),30, 'g','filled'); 
% % %     scatter(data(index1,1),data(index1,2),30, 'c','filled');
% % %     title 'Movie Clustering'
% % %     xlabel 'Genre Codes';
% % %     ylabel 'Duration (min)';
% % %      
% % % end





% x1 = min(X(:,1)):0.01:max(X(:,1));
% x2 = min(X(:,2)):0.01:max(X(:,2));
% [x1G,x2G] = meshgrid(x1,x2);
% XGrid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot
% 
% idx2Region = kmeans(XGrid,5,'MaxIter',1,'Start',C);
% 
% figure;
% gscatter(XGrid(:,1),XGrid(:,2),idx2Region,...
%     ['r';'b';'g';'c';'y'],'..');
% hold on;
% plot(X(:,1),X(:,2),'k*','MarkerSize',5);
% title 'Movie Clustering';
% xlabel 'Genre Codes';
% ylabel 'Duration (min)';
% legend('Region 1','Region 2','Region 3','Region 4','Region 5','Data','Location','SouthEast');
% hold off;
