function [input,target,Para,W1,W2,W3,lambda_1,lambda_2] = Base_para(learning_type,digit,inhibition)

load('inputValues.mat');load('targetValues.mat');
Para.num_classes = 10;
Para.nMF = 12;Para.nGC = 50000; Para.nGoC = 5000; Para.nPk = 3;
Para.conv = 4; Para.conv_2 = 5; Para.conv_3 = 4; 
Para.lrnRate = [7*1E-3;7*1E-3;7*1E-3]; Para.nTrials = 1000;

rng(19990516);
% （1）采样矩阵
    W1 = zeros(Para.nGC,Para.nMF);W2 = zeros(Para.nGoC,Para.nGC);W3 = zeros(Para.nGC,Para.nGoC);
    for k = 1:Para.nGC
        sel_1 = randsample(Para.nMF,Para.conv);W1(k,sel_1) = 1/Para.conv;
    end  
    for k = 1:Para.nGoC
        sel_2 = randsample(Para.nGC,Para.conv_2);W2(k,sel_2) = 1/Para.conv_2;
    end
    for k = 1:Para.nGC
        sel_3 = randsample(Para.nGoC,Para.conv_3);W3(k,sel_3) = 1/Para.conv_3;
    end

switch learning_type  
    case {'single'} 
            % （2）所有数字合并
%              input  = inputValues(1:digit+1);target = targetValues(1:digit+1);
%              input = horzcat(input{:});target = horzcat(target{:});
%              input = {input};target = {target};
            % （2）选取某个数字
            input  = inputValues(digit+1);target = targetValues(digit+1);
            % （3）采样哪种抑制方式
            if inhibition == 1 % FFI for single
                lambda_1 = [0.1:0.07:2.5];
                lambda_2 = zeros(1,35);
            elseif inhibition == 2 % FBI for single
                lambda_1 = zeros(1,35);%zeros(1,35);
                lambda_2 = [0.10 0.40 0.50 0.60 0.70 0.80 0.90 1.00 1.10 1.20...
                     1.30 1.40 1.50 1.60 1.70 1.80 1.90 2.10 2.30 2.90...
                     3.00 3.30 3.40 3.50 3.70 3.90 4.20 4.80 5.00 5.20...
                     5.90 6.60 7.10 8.40 10.00];
             elseif inhibition == 3 % FFI+FBI for single
                lambda_1 = [0.1:0.07:2.5];
                lambda_2 = [0.10 0.40 0.50 0.60 0.70 0.80 0.90 1.00 1.10 1.20...
                     1.30 1.40 1.50 1.60 1.70 1.80 1.90 2.10 2.30 2.90...
                     3.00 3.30 3.40 3.50 3.70 3.90 4.20 4.80 5.00 5.20...
                     5.90 6.60 7.10 8.40 10.00];
            else
                sprintf('This type of inhibition does not exist')
            end
        
        case {'continual'} 
             % （2）设置学习哪个数字
            input  = inputValues(1:digit+1);target = targetValues(1:digit+1);

             % （3）采样哪种抑制方式
             if inhibition == 2 % FBI
                B = [0.10 0.40 0.50 0.60 0.70 0.80 0.90 1.00 1.10 1.20...
                     1.30 1.40 1.50 1.60 1.70 1.80 1.90 2.10 2.30 2.90...
                     3.00 3.30 3.40 3.50 3.70 3.90 4.20 4.80 5.00 5.20...
                     5.90 6.60 7.10 8.40 10.00];
                for i = 1:35
                    lambda_1{i} = zeros(1,10);
                    lambda_2{i} = B(i)*ones(1,10);
                end    
            else
                sprintf('This type of inhibition does not exist')
             end
end


end