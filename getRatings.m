%Gets ratings from ratings file
function [ ratingsMatrix ] = getRatings( path )

    u1 = load(path);

    ratingsMatrix = zeros(943,1682);

    for i = 1:length(u1)
        ratingsMatrix(u1(i,1), u1(i,2)) = u1(i,3);
    end

end

