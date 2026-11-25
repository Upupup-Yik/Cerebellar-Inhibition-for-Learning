function [noisy_matrix] = Noisy(input)
    % 设置矩阵的维度和噪声的标准差
    [rows,cols] = size(input);noisy_matrix = input; 
    num_elements = floor(cols * 0.2); noise_std = 0.01;   
    for r = 1:rows
        noisy_indices = randperm(cols, num_elements);
        noise = noise_std * randn(1, num_elements);
        noisy_matrix(r, noisy_indices) = noisy_matrix(r, noisy_indices) + noise;
    end
end
