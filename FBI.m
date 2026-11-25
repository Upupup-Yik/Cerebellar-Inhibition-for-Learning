function [gc_2,num_nonzero] = FBI(gc_1,thr_2,lambda_2,classes,Para)

    if classes == 1
         gc_2 = gc_1 - lambda_2 * thr_2;
         gc_2(gc_2 < 0 ) = 0;
         num_nonzero = mean(sum(gc_2 ~= 0)/Para.nGC);
    else
        for j = 1:classes
            gc_2{j} = gc_1{j} - lambda_2(j) * thr_2{j};
            gc_2{j}(gc_2{j} < 0 ) = 0;
            num_nonzero(j) = mean(sum(gc_2{j} ~= 0)/Para.nGC);
        end
    end

end