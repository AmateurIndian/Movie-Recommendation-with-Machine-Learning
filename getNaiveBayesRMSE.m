%Calculates RMSE value for a single cluster, used by:
%kmeansclustering.m
function [ rmseVal ] = getNaiveBayesRMSE( class, idx, data )

    cluster = find(idx == class);
    val = 0;

    for i = 1:length(cluster)
        val = val + data(cluster(i), 3);
    end
    meanVal = val/length(cluster);
    errNum = 0;
    for i = 1:length(cluster)
        errNum = errNum + (meanVal-data(cluster(i),3))*(meanVal-data(cluster(i),3));
    end
    rmseVal = sqrt(errNum/length(cluster));
    %fprintf('RMSE for cluseter%d is: %f',class,rmseVal);
end

