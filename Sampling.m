function [gc,gc_test,mu,thr,thr_test] = Sampling(input,Para,W1,W2,W3)

nMF = Para.nMF;nGC = Para.nGC; nGoC = Para.nGoC; 
conv = Para.conv;conv_2 = Para.conv_2;conv_3 = Para.conv_3; 
classes = Para.classes; 
A = 0; B = 1; C = 0.1;% A = 0.1; B = 1.5; C = 0.2;


for m = 1:classes
    mu(m)    =  mean(mean(input{m}));        
    gc{m} = W1 * input{m};goc{m} = W2 * gc{m};goc{m}(goc{m}<A) = 0; goc{m}= B * goc{m};
    % 产生test样本
    [noisy_mf] = Noisy(input{m});gc_test{m} = W1 * noisy_mf;
    goc_test{m}= W2 * gc_test{m}; goc_test{m}(goc_test{m}<A)=0; goc_test{m}= B * goc_test{m};
    % 失活一部分goc
    [a_2,b_2] = size(goc{m});
    totalNum_2 = a_2 * b_2;
    Index_2 = 1 + floor(rand(1,floor(totalNum_2*C)) * totalNum_2);
    goc{m}(Index_2)=0; goc_test{m}(Index_2)=0;
    % 反馈阈值
    thr{m} = W3 * goc{m}; thr_test{m} = W3 * goc_test{m};
end
                    

end




