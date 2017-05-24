
% Puts information of all movies in cell array matrix
function [movieInfo] = getMovieInfo(path)
    movieInfo = cell(1682,8);
    file = fopen(path);
    line = fgets(file);
    counter = 1;
    while (line > 0)
        info = split(line, ',');
        for i = 1:length(info)
            movieInfo{counter, i} = info(i);
        end  
        line = fgets(file);
        counter = counter + 1;
    end
end

