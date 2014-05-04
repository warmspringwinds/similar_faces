function [ reconstructed_data ] = reconstruct( project_matrix, data_to_reconstruct, data_mean )
    % Reconstructs specified data into previous coordinate system which is described
    % by projecting matrix. If data mean is specified it is added to
    % each data sample. After reconstruction the data won't be the same as
    % it was before projecting.
    % Input:
    % @project_matrix - matrix where each column is a vector specifing a
    % new coordinate axe
    % @data_to_project - matrix where each row is a data sample to
    % reconstruct
    % @data_mean - row that represents mean of data matrix that was
    % computed on the data before projecting.
    % Output:
    % @reconstructed_data - matrix where each row is a reconstructed data
    % sample from @data_to_reconstruct
    
    reconstructed_data = data_to_reconstruct * project_matrix';

    if (nargin > 2)
        % If mean value of data was specified, then add it to each
        % data sample after projecting.
        reconstructed_data = reconstructed_data + repmat(data_mean, size(data_to_reconstruct, 1), 1);
    end
    
end

