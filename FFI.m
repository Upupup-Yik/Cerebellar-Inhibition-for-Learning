function [gc_1] = FFI(gc,mu,lambda,classes)

    if classes == 1
                thr_1 = lambda  * mu;
                gc_1  = gc - thr_1;
                gc_1(gc_1 < 0 ) = 0;
    else
            for j = 1:classes
                thr_1 = lambda(j)  * mu(j) ;
                gc_1{j} = gc{j} - thr_1;
                gc_1{j}(gc_1{j} < 0 ) = 0;
            end
    end

end