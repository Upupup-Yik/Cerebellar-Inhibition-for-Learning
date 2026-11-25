function [output] = RunFilter_senmor(input,target,gc,W,Para)

nMF = size(input,1);nGC = size(gc,1);nPk = size(target,1);nPts = size(target,2);
nTr = Para.nTrials;lrnRate = Para.lrnRate;

% training loop
mse = zeros(1, nTr+1);
for k = 1:nTr
    pk = W * gc; mse(:,k) = mean(mean((pk-target).^2,2));
    for i = 1:nPts
        error = (W * gc(:,i) - target(:,i));
        W = W - (lrnRate .* error .* gc(:,i)');
        W(W<-1)=-1;W(W>1)=1;
    end
    W(isnan(W)) = 0;  
end

pk = W * gc;mse(:, nTr+1) = mean(mean((pk-target).^2,2));
output.encode = pk;output.mse = mse;output.W = W;

end

