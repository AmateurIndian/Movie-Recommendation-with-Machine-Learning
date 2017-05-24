function [ mainGenre ] = getMainGenre( path )

    file = fopen(path);
    line = fgets(file);
    counter = 1;
    while (line > 0)
       tokens = split(line,')');
       if length(tokens) >2
            genreList = split(tokens(3,1), '|');
            indexes = find(genreList == '1');
            if length(indexes > 0)
                mainGenre(counter, 2) = indexes(1) -1;

                movieId = split(tokens(1,1), '|');
                mainGenre(counter, 1) = movieId(1);

            else
                mainGenre(counter,2) = -1;
            end
       else
           mainGenre(counter, 2) = -1;
       end
        counter = counter + 1;
        line = fgets(file);
    end


end

