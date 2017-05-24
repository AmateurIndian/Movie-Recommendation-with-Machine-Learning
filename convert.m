function result = convert(filename)
	matrix = importdata(filename);
	numofusers = 943;
	numoffilms = 1682;
	result = zeros(numofusers,numoffilms);
	for i = 1:numofusers
	    index = find(matrix(:,1) == i);
	    result(i,matrix(index,2)) = matrix(index,3);
	end
end