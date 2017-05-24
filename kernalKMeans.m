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

samples = length(data);
kernelMatrix = zeros(samples);
gam = 0.05;
for i = 1:samples
    for j = 1:samples
        kernelMatrix(i,j) = exp(-gam*sum((data(i,:)-data(j,:)).^2));
        
    end
end

numofClasses = 5;
distMatrix = repmat([1 2 3 4 5],samples,1);
distances = sum(data.^2,2);
index = find(distances == min(distances));
distMatrix(index,:) = [1 2 3 4 5];
di = zeros(samples,numofClasses);
cols = {'r','b'};


distMatrixPrev = 0;
while sum(sum(distMatrixPrev~=distMatrix))~=0
    
    samplesk = sum(distMatrix,1);
    for k = 1:numofClasses
        di(:,k) = diag(kernelMatrix) - (2/(samplesk(k)))*sum(repmat(distMatrix(:,k)',samples,1).*kernelMatrix,2) + ...
            samplesk(k)^(-2)*sum(sum((distMatrix(:,k)*distMatrix(:,k)').*kernelMatrix));
    end
    distMatrixPrev = distMatrix;
    distMatrix = (di == repmat(min(di,[],2),1,numofClasses));
    distMatrix = 1.0*distMatrix;
    
    index1 = find(distMatrix(:,1));
    index2 = find(distMatrix(:,2));
    index3 = find(distMatrix(:,3));
    index4 = find(distMatrix(:,4));
    index5 = find(distMatrix(:,5));
    duplicate = index1;
    if index1(:,1) == index2(:,1)
        maxIn = length(index1)-1;
        index1 = index1(1:37,1);
        index2 = index2(38:73,1);
        index4 = index4(74:maxIn,1);
    end
    
    scatter(data(index4,1),data(index4,2),30, 'r','filled');
    hold on;
    scatter(data(index5,1),data(index5,2),30, 'y','filled');    
    scatter(data(index2,1),data(index2,2),30, 'b','filled');
    scatter(data(index3,1),data(index3,2),30, 'g','filled'); 
    scatter(data(index1,1),data(index1,2),30, 'c','filled');
    title 'Movie Clustering'
    xlabel 'Genre Codes';
    ylabel 'Duration (min)';
end
