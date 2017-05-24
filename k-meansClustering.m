% %K-means clustering with features duration and main genre to check ratings
% %of specific user.

user = 1;
path = './Dataset/movieData.txt';

movieMat = getMovieInfo(path);
ratings = load('./Dataset/u.data');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
fileMovies = fopen('./Dataset/u.item');
movieIndex = find(ratings(:,1) == user);
genreMat = getMainGenre('./Dataset/u.item');
                            
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

figure;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
plot(X(idx==3,1),X(idx==3,2),'g.','MarkerSize',12)
plot(X(idx==4,1),X(idx==4,2),'k.','MarkerSize',12)
plot(X(idx==5,1),X(idx==5,2),'y.','MarkerSize',12)
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2','Cluster 3','Cluster 4','Cluster 5','Centroids',...
       'Location','NW')
title 'Movie Clustering'
xlabel 'Genre Codes';
ylabel 'Duration (min)';
hold off


% % X = data(:,1:2);
% % 
% % figure;
% % plot(X(:,1),X(:,2),'k*','MarkerSize',5);
% % title 'Movie Ratings';
% % xlabel 'Genre Codes';
% % ylabel 'Duration (min)';
% % 
% % rng(1); % For reproducibility
% % [idx,C] = kmeans(X,5);
% % 
% % x1 = min(X(:,1)):0.01:max(X(:,1));
% % x2 = min(X(:,2)):0.01:max(X(:,2));
% % [x1G,x2G] = meshgrid(x1,x2);
% % XGrid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot
% % 
% % idx2Region = kmeans(XGrid,5,'MaxIter',1,'Start',C);
% % 
% % figure;
% % gscatter(XGrid(:,1),XGrid(:,2),idx2Region,...
% %     [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0],'..');
% % hold on;
% % plot(X(:,1),X(:,2),'k*','MarkerSize',5);
% % title 'Fisher''s Iris Data';
% % xlabel 'Petal Lengths (cm)';
% % ylabel 'Petal Widths (cm)';
% % legend('Region 1','Region 2','Region 3','Region 4','Region 5','Data','Location','SouthEast');
% % hold off;

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




