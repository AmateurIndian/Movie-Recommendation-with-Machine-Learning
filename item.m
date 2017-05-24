

% ratings = [ 1 0 2 0 0 1;
%             0 0 4 2 0 0;
%             3 5 0 4 4 3;
%             0 4 1 0 3 0;
%             0 0 2 5 4 3;
%             5 0 0 0 2 0;
%             0 4 3 0 0 0;
%             0 0 0 4 0 2;
%             5 0 4 0 0 0;
%             0 2 3 0 0 0;
%             4 1 5 2 2 4;
%             0 3 0 0 5 0];

ratings = getRatings('./Dataset/u1.base');

k = 2;
m = 1;
u = 5;
movieNames = [1 2 3 4 5 6];
userNames = [1 2 3 4 5 6 7 8 9 10 11 12];

 normalised = normaliseRatings(ratings);
%  [itemRatings,itemIndex] = findItem(normalised, movieNames, m);
%  simMatrix = getSimilarity(normalised, itemRatings);
%  [sortedRatings, realIndex] = sort(simMatrix, 'descend');
%  userIndex = findUserIndex(userNames, u);
%  value = calcSim(ratings, userIndex, k, simMatrix, itemIndex);

function predict = calcSim(ratings, userIndex, k, simMatrix, m)
    
    [sortedRatings, realIndex] = sort(simMatrix, 'descend');
    
    simSum = 0;
    ratingsSum = 0;
    count = 1;
    
    while ((count <= k) && k <= length(ratings(1,:)))
        
        if(realIndex(count) == m)
            k = k+1;
        else
            if(ratings(userIndex, realIndex(count)) ~= 0)
                simSum = simSum +simMatrix(realIndex(count));
                ratingsSum = ratingsSum + simMatrix(realIndex(count))*ratings(userIndex, realIndex(count));
            else
                k = k+1;
            end
        end
        count = count+1; 
    end
    predict = ratingsSum/simSum;
end

function simMatrix = getSimilarity (normalised, movieRatings)
    numOfMovies = length(normalised(1,:));
    simMatrix = zeros(1, numOfMovies);

    sv = movieRatings.*movieRatings;
    userMag = sum(sv);
    userMag = sqrt(userMag);

    for i = 1:numOfMovies
        sv = normalised(:,i).*normalised(:,i);
        mag = sum(sv);
        mag = sqrt(mag); 
        denom = mag*userMag;
        num = dot(movieRatings, normalised(:,i));
        sim =  num/denom;
        if(isnan(sim))
            sim = 0;
        end
        simMatrix(1,i) = sim;
    end
end



function [itemRatings, itemIndex]  = findItem (normalisedRatings, itemList, item)
    [r, itemIndex] = ismember(item,itemList);
    if(itemIndex ~= 0)
        itemRatings = normalisedRatings(:,itemIndex);
    else
        itemRatings = 0;
    end
end

function [userIndex]  = findUserIndex (userNames, user)
    [r, userIndex] = ismember(user,userNames);
end

function normalisedRatings  = normaliseRatings (ratings)

    numOfUsers = length(ratings(:,1));
    numOfMovies = length(ratings(1,:));

    for i = 1:numOfMovies
        avg = sum(ratings(:,i))/nnz(ratings(:,i));

        for j = 1:numOfUsers
            if ratings(j,i) ~=0
                ratings(j,i) = ratings(j,i) - avg;
            end
        end
    end
    normalisedRatings = ratings;
end