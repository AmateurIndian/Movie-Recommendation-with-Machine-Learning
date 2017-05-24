function [ rmseVal ] = getRMSEUserProfile( class, idx, data )
    
    max = sum(data(idx ==class,3) == 1); 

    if sum(data(idx==class,3) ==2) > max
       max = sum(data(idx ==class,3) == 2);
       meanVal = 2;
    elseif sum(data(idx==class,3) ==3) > max;
       max = sum(data(idx ==class,3) == 3);
       meanVal = 3;
    elseif sum(data(idx==class,3) ==4) > max;
       max = sum(data(idx ==class,3) == 4);
       meanVal = 4;
    elseif sum(data(idx==class,3) ==5) > max;
       max = sum(data(idx ==class,3) == 5);
       meanVal = 5;
    else
        meanVal = 1;
    end

    cluster = find(idx == class);
    val = 0;

    for i = 1:length(cluster)
        val = val + data(cluster(i), 3);
    end
   
    errNum = 0;
    for i = 1:length(cluster)
        errNum = errNum + (meanVal-data(cluster(i),3))*(meanVal-data(cluster(i),3));
    end
    rmseVal = sqrt(errNum/length(cluster));
    %fprintf('RMSE for cluseter%d is: %f',class,rmseVal);


end

