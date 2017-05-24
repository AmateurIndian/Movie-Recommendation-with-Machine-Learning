function [ data ] = loadDataNaiveBayes( moviePath, itemPath, userPath, user  )
    
    data = -1;
%     user = 1;
%     path = './Dataset/movieData.txt';

    movieMat = getMovieInfo(moviePath);
    ratings = load(userPath);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    fileMovies = fopen(itemPath);
    movieIndex = find(ratings(:,1) == user);
    genreMat = getMainGenre(itemPath);
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
                    if duration > 200
                        data(counter,2) = 7;
                    elseif duration > 180
                         data(counter,2) = 6;
                    elseif duration > 150
                        data(counter, 2) = 5;
                    elseif duration > 120
                        data(counter, 2) = 4;
                    elseif duration > 90
                        data(counter, 2) = 3;
                    elseif duration > 60
                        data(counter, 2) = 2;
                    else
                        data(counter, 2) = 1;
                    end  
                    data(counter,3) = movieRating;
                    counter = counter + 1;
                end
            end  
        end
    end

end

