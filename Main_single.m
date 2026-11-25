%% ============Code for single learning========
clc,clear all
[input,target,Para,W1,W2,W3,lambda_1,lambda_2] = Base_para('single',9,3);
% 9 is a digit number, can be changed to 0-9
basePath = '~';

for Trial = 1:10
     Para.classes = 1;
     [gc,gc_test,mu,thr,thr_test] = Sampling(input,Para,W1,W2,W3);
     classes = Para.classes;num = length(lambda_1);
     Mse = cell(num,classes); Mse_Train = zeros(num,classes);Mse_Test = zeros(num,classes);
     Count = zeros(num,classes); 
      
    parfor i = 1:num
       GC_W = cell(1,classes);
       gc_1=[];gc_2=[];gc_test_1=[];gc_test_2=[];W = [];
       Mse_continual = [];record = [];
       gc_1 = FFI(gc{1},mu,lambda_1(i),classes);
       [gc_2,Count(i,:)] = FBI(gc_1,thr{1},lambda_2(i),classes,Para);
       gc_test_1 = FFI(gc_test{1},mu,lambda_1(i),classes);
       [gc_test_2,~] = FBI(gc_test_1,thr_test{1},lambda_2(i),classes,Para);
       W = rand(Para.nPk, Para.nGC); W = W./size(W,2);
       for k = 1:classes
           [results] = RunFilter_senmor(input{k},target{k},gc_2,W,Para);
            GC_W{k} = results.W;W = GC_W{k};
            Mse{i,k} = results.mse;Mse_Train(i,k) = Mse{i,k}(end:end);
            Mse_Test(i,k) = mean(mean((GC_W{k}*gc_test_2{k}- target{k}).^2,2));
            [Mse_continual{k},record{k}] = Continual_test(k,W,gc_test_2,target);
       end         
       record_2{i} = Mse_continual;
       record_3{i} = record;
       record_4{i} = GC_W;
    end 
    folderPath = fullfile(basePath, num2str(Trial));
    mkdir(folderPath);
    dataFilePath = fullfile(folderPath,'Count');
    save(dataFilePath, 'Count');
    dataFilePath = fullfile(folderPath,'record_2');
    save(dataFilePath, 'record_2');
    dataFilePath = fullfile(folderPath,'record_3');
    save(dataFilePath, 'record_3');
    if Trial ==1
        dataFilePath = fullfile(folderPath,'record_4');
        save(dataFilePath, 'record_4');
    end

    % 可选：输出保存的文件路径
    fprintf('Saved to %s\n', dataFilePath);
end


