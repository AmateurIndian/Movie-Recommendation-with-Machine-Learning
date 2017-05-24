function [ normalisedRatings ] = normaliseRatings( ratings )
    numOfUsers = length(ratings(:,1));
    numOfMovies = length(ratings(1,:));

    for i = 1:numOfUsers
        avg = sum(ratings(i,:))/nnz(ratings(i,:));

        for j = 1:numOfMovies
            if ratings(i,j) ~=0
                ratings(i,j) = ratings(i,j) - avg;
            end
        end
    end
    normalisedRatings = ratings;
end

