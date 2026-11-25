function [A,B] = Continual_test(k,W,gc_test_2,target)
       
   for n=1:k
       A(n) = mean(mean(W * gc_test_2{n}- target{n}).^2,2 );
       B{n} =  W * gc_test_2{n};
   end

end