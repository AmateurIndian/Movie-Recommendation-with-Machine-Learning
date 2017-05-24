%User-User collaborative filtering
%realRatings = convert('u1_base.txt');
%ratings = getRatings('./Dataset/u1.base');

ratings = [ 4 0 0 5 1 0 0;
            5 5 4 0 0 0 0;
            0 0 0 2 4 5 0;
            0 3 0 0 0 0 3];

k = 100;
m = 2;
u = 1;
movieNames = 6;
userNames = 2;

normalised = normaliseRatings(ratings); 



%value = calcSim(ratings, simMatrix, k, m);


testData =load ('./Dataset/u1.test');
errNum = 0;
count = 0;
for person = 1:80
    u = testData(person,1);
    m = testData(person,2);
    
    simMatrix = getSimilarity(normalised, u);
    val = calcSim(ratings, simMatrix, k, m);
    count = count + 1;
    errNum = errNum + (val-testData(person,3))*(val-testData(person,3));
end

errNum = sqrt(errNum/person)

 function predict = calcSim(ratings, simMatrix, k, m)
    
    [sortedMat, realIndex] = sort(simMatrix, 'descend');
    sum = 0;
    sumSim = 0;
    k = k+1;
    i = 2;
    while (i  <=k) && (k <= length(realIndex))
        %fprintf ('K: %d and i: %d\n', k,i);
      
        userRate = ratings(realIndex(i),m);
        %fprintf ('    USER RATE: %d\n', userRate);
        if userRate == 0
            k = k+1;
           % fprintf ('NEW K: %d and i: %d\n', k,i);
        else
            sum = sum + userRate* sortedMat(i);
            sumSim = sumSim + sortedMat(i);
        end
        i = i+ 1;
    end
    predict = sum/(sumSim);

end

function simMatrix = getSimilarity (normalised, u)
    userRatings = normalised(u,:);
    simMatrix = zeros(1,length(normalised(:,1)));
    for i = 1:length(normalised(:,1))
        target = normalised(i,:);
        num = dot(userRatings, target);
        denom = sqrt(sum((userRatings.*userRatings)))*sqrt(sum((target.*target)));
        val = num/denom;

        if isnan(val)
            simMatrix(1,i) = 0;
        else
            simMatrix(1,i) = val;
        end
    end
end



% function normalisedRatings  = normaliseRatings (ratings)
% 
%     numOfUsers = length(ratings(:,1));
%     numOfMovies = length(ratings(1,:));
% 
%     for i = 1:numOfUsers
%         avg = sum(ratings(i,:))/nnz(ratings(i,:));
% 
%         for j = 1:numOfMovies
%             if ratings(i,j) ~=0
%                 ratings(i,j) = ratings(i,j) - avg;
%             end
%         end
%     end
%     normalisedRatings = ratings;
% end

