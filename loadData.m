clear; 
clc;
ratings = load('./Dataset/u.data');

movieInfo = getMovieInfo('./Dataset/movieData.txt');

file = fopen('./Dataset/u.user');

line = fgets(file);
counter = 1;

while (line > 0)
    user = split(line, '|');
    for i = 1:length(user)
        userInfo(counter,i) = user(i);
    end
    
    line = fgets(file);
    counter = counter + 1;
end


file = fopen('./Dataset/occupations');

line = fgets(file);
counter = 1;

while (line > 0)
    jobsList = split(line, '|');
    for i = 1:length(jobsList)
        occupations(i,1) = jobsList(i);
    end
    line = fgets(file);
end

for m = 1:1682
    
    values(1,m) = m;
    [realIndex] = find(ratings(:,2) == m);

    for i = 1:length(realIndex)
        uId = ratings(realIndex(i), 1);
        uAge = userInfo(uId, 2);
        uJob = userInfo(uId, 4);
        uJobFound = find(occupations == uJob);
        uRating = ratings(realIndex(i), 3);
        movieUserMat(i,1) = uId;
        movieUserMat(i,2) = uRating;
        movieUserMat(i,3) = uAge;
        movieUserMat(i,4) = uJobFound;
    end

%     scatter(movieUserMat(:,3), movieUserMat(:,4), 10,'r');

    movieUserMat(:,1) = movieUserMat(:,3);
    movieUserMat(:,3) = movieUserMat(:,2);
    movieUserMat(:,2) = movieUserMat(:,4);
    

    X = movieUserMat(:,1:2);

    opts = statset('Display','final');
    [idx,C] = kmeans(X,5,'Distance','cityblock',...
        'Replicates',5,'Options',opts);


    rmse1 = getNaiveBayesRMSE(1, idx, movieUserMat);
    rmse2 = getNaiveBayesRMSE(2,idx,movieUserMat);
    rmse3 = getNaiveBayesRMSE(3,idx,movieUserMat);
    rmse4 = getNaiveBayesRMSE(4,idx,movieUserMat);
    rmse5 = getNaiveBayesRMSE(5,idx,movieUserMat);
    avgRMSE = (rmse1 + rmse2 + rmse3 + rmse4 + rmse5)/5;
    
    values(2,m) = avgRMSE;
    fprintf('RMSE for item%d is: %f',m,avgRMSE);
    
   
    
end

scatter(values(1,:),values(2,:),15,'k','filled')
title 'Movie Clustering'
xlabel 'User Ids';
ylabel 'RMSE Values';
hold on
title 'User Behaviour'
xlabel 'RMESE value';
ylabel 'Item ID';
hold off

% figure;
% scatter(X(idx==1,1),X(idx==1,2),15,'r','filled')
% hold on
% scatter(X(idx==2,1),X(idx==2,2),15,'b','filled')
% scatter(X(idx==3,1),X(idx==3,2),15,'g','filled')
% scatter(X(idx==4,1),X(idx==4,2),15,'c','filled')
% scatter(X(idx==5,1),X(idx==5,2),15,'y','filled')
% scatter(C(:,1),C(:,2),12,'k','LineWidth',3)
% legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Centroids',...
%        'Location','NE')
% title 'User Behaviour'
% xlabel 'Age (Yrs)';
% ylabel 'Occupation Code';
% hold off

% c1 = zeros(1,2);
% c1New = zeros(1,2);
% c2 = zeros(1,2);
% c2New = zeros(1,2);
% c3 = zeros(1,2);
% c3New = zeros(1,2);
% c4 = zeros(1,2);
% c4New = zeros(1,2);
% c5 = zeros(1,2);
% c5New = zeros(1,2);
% min = 1;
% max = length(data);
% point1 = round(min + (max-min).*rand());
% point2 = round(min + (max-min).*rand());
% point3 = round(min + (max-min).*rand());
% point4 = round(min + (max-min).*rand());
% point5 = round(min + (max-min).*rand());
% 
% c1(1) = data(point1,1)
% c1(2) = data(point1,2)
% c2(1) = data(point2,1)
% c2(2) = data(point2,2)
% c3(1) = data(point3,1)
% c3(2) = data(point3,2)
% c4(1) = data(point4,1)
% c4(2) = data(point4,2)
% c5(1) = data(point5,1)
% c5(2) = data(point5,2)
% c1Val = data(point1,3)
% c2Val = data(point2,3)
% c3Val = data(point3,3)
% c4Val = data(point4,3)
% c5Val = data(point5,3)
% c1dist = 1000; 
% c2dist = 1000;
% c3dist = 1000;
% c4dist = 1000;
% c5dist = 1000;
% while (c1dist > 0.05 && c2dist > 0.05 && c3dist > 0.05 && c4dist > 0.05 && c5dist > 0.05)
% 
%     for i = 1:length(data)
%         c1Vec = [c1(1),c1(2);data(i,1),data(i,2)];
%         c2Vec = [c2(1),c2(2);data(i,1),data(i,2)];
%         c3Vec = [c3(1),c3(2);data(i,1),data(i,2)];
%         c4Vec = [c4(1),c4(2);data(i,1),data(i,2)];
%         c5Vec = [c5(1),c5(2);data(i,1),data(i,2)];
%         c1dist = pdist(c1Vec, 'euclidean');
%         c2dist = pdist(c2Vec, 'euclidean');
%         c3dist = pdist(c3Vec, 'euclidean');
%         c4dist = pdist(c4Vec, 'euclidean');
%         c5dist = pdist(c5Vec, 'euclidean');
%         
%         data(i,4) = 1;
%         if c1dist < c2dist
%             data(i,4) = 2;
%         end
%         if c1dist < c3dist
%             data(i,4) = 3;
%         end
%         if c1dist < c4dist
%             data(i,4) = 4;
%         end
%         if c1dist < c5dist
%             data(i,4) = 5;
%         end
%     end
% 
%     indC1 = data(:,4) == 1;
%     c1Arr = data(indC1,:);
%     indC2 = data(:,4) == 2;
%     c2Arr = data(indC2,:);
%     indC3 = data(:,4) == 3;
%     c3Arr = data(indC3,:);
%     indC4 = data(:,4) == 4;
%     c4Arr = data(indC4,:);
%     indC5 = data(:,4) == 5;
%     c5Arr = data(indC5,:);
% 
%     c1New(1) = mean( c1Arr(:,1));
%     c1New(2) = mean( c1Arr(:,2));
%     c2New(1) = mean( c2Arr(:,1));
%     c2New(2) = mean( c2Arr(:,2));
%     c3New(1) = mean( c3Arr(:,1));
%     c3New(2) = mean( c3Arr(:,2));
%     c4New(1) = mean( c4Arr(:,1));
%     c4New(2) = mean( c4Arr(:,2));
%     c5New(1) = mean( c5Arr(:,1));
%     c5New(2) = mean( c5Arr(:,2));
% 
%     c1Vec = [c1(1),c1(2);c1New(1),c1New(2)];
%     c2Vec = [c2(1),c2(2);c2New(1),c2New(2)];
%     c3Vec = [c3(1),c3(2);c3New(1),c3New(2)];
%     c4Vec = [c4(1),c4(2);c4New(1),c4New(2)];
%     c5Vec = [c5(1),c5(2);c5New(1),c5New(2)];
%     
%     c1dist = pdist(c1Vec, 'euclidean');
%     c2dist = pdist(c2Vec, 'euclidean');
%     c3dist = pdist(c3Vec, 'euclidean');
%     c4dist = pdist(c4Vec, 'euclidean');
%     c5dist = pdist(c5Vec, 'euclidean');
%     
%     c1 = c1New;
%     c2 = c2New;
%     c3 = c3New;
%     c4 = c4New;
%     c5 = c5New;
% end
% 
% c1X = c1Arr(:,1);
% c1Y = c1Arr(:,2);
% 
% scatter(c1Arr(:,1),c1Arr(:,2),20, 'r','filled');
% hold;
% scatter(c2Arr(:,1),c2Arr(:,2),20, 'b','filled');
% scatter(c3Arr(:,1),c3Arr(:,2),20, 'g','filled');
% scatter(c4Arr(:,1),c4Arr(:,2),20, 'y','filled');
% scatter(c5Arr(:,1),c5Arr(:,2),20, 'k','filled');
% 
% scatter(c1(1),c1(2),80,'MarkerEdgeColor','k',...
%                           'MarkerFaceColor','r',...
%                           'LineWidth',1.5);
% scatter(c2(1),c2(2),80,'MarkerEdgeColor','k',...
%                           'MarkerFaceColor','b',...
%                           'LineWidth',1.5);
% scatter(c3(1),c3(2),80,'MarkerEdgeColor','k',...
%                           'MarkerFaceColor','g',...
%                           'LineWidth',1.5);
% scatter(c4(1),c4(2),80,'MarkerEdgeColor','k',...
%                           'MarkerFaceColor','y',...
%                           'LineWidth',1.5);
% scatter(c5(1),c5(2),80,'MarkerEdgeColor','k',...
%                           'MarkerFaceColor','k',...
%                           'LineWidth',1.5);




% data(:,1) = movieUserMat(:,3);
% data(:,2) = movieUserMat(:,4);
% 
% samples = length(data);
% kernelMatrix = zeros(samples);
% gam = 0.005;
% for i = 1:samples
%     for j = 1:samples
%         kernelMatrix(i,j) = exp(-gam*sum((data(i,:)-data(j,:)).^2));
%     end
% end
% 
% numofClasses = 5;
% distMatrix = repmat([1 2 3 4 5],samples,1);
% distances = sum(data.^2,2);
% index = find(distances == min(distances));
% distMatrix(index,:) = [1 2 3 4 5];
% di = zeros(samples,numofClasses);
% cols = {'r','b'};
% 
% 
% distMatrixPrev = 0;
% while sum(sum(distMatrixPrev~=distMatrix))~=0
%     
%     samplesk = sum(distMatrix,1);
%     for k = 1:numofClasses
%         di(:,k) = diag(kernelMatrix) - (2/(samplesk(k)))*sum(repmat(distMatrix(:,k)',samples,1).*kernelMatrix,2) + ...
%             samplesk(k)^(-2)*sum(sum((distMatrix(:,k)*distMatrix(:,k)').*kernelMatrix));
%     end
%     distMatrixPrev = distMatrix;
%     distMatrix = (di == repmat(min(di,[],2),1,numofClasses));
%     distMatrix = 1.0*distMatrix;
% 
%     index1 = find(distMatrix(:,1));
%     index2 = find(distMatrix(:,2));
%     index3 = find(distMatrix(:,3));
%     index4 = find(distMatrix(:,4));
%     index5 = find(distMatrix(:,5));
%     scatter(data(index4,1),data(index4,2),30, 'r','filled');
%     hold on;
%     scatter(data(index2,1),data(index2,2),30, 'b','filled');
% %     scatter(data(index3,1),data(index3,2),30, 'g','filled'); 
% %     scatter(data(index1,1),data(index1,2),30, 'b','filled'); 
% %     scatter(data(index5,1),data(index5,2),30, 'y','filled'); 
% end

