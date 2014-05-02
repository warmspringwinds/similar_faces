function [ descending_eigen_vectors, overall_mean ] = principal_component_analysis( samples, amount_of_biggest_eigen_vectors_to_leave )
    %   Carries out Principal Component Analysis on specified sample data
    %   Creates new system preserving as much variation as possible while
    %   carrying out dimension reduction.
    %   Input:
    %   @samples - Matrix where rows are samples
    %   @amount_of_biggest_eigen_vectors_to_leave - the size of the new
    %   coordinate system. The max size is c - 1 where c is the amount of
    %   classes
    %   Output:
    %   @descending_eigen_vectors - coordinate axes of the new system which
    %   are placed in columns of @descending_eigen_vectors. Vectors will be
    %   normalized.
    %   @overall_mean - mean of sample data. Used to subtract from data
    %   samples before projecting into new coordinate system
    
    [sample_amount, sample_dimension] = size( samples );
    
    overall_mean = mean( samples );
    
    samples = samples - repmat(overall_mean, sample_amount, 1);
    
    if (sample_amount > sample_dimension)
        % If amount of samples is greater than the dimension of samples,
        % then principle axes are computed through scatter matrix. In this
        % case no optimisation is used to speed this process.
        
        scatter_matrix = (samples') * samples;
        
        % Find eigen values and vectors
        [column_eigen_vectors, diagonal_eigen_values] = eig( scatter_matrix );

        % Sort eigenvalues in descending order
        [descending_eigen_values, descending_eigen_values_index] = sort(diag(diagonal_eigen_values), 'descend');

        % Sort eigenvectors accordingly
        descending_eigen_vectors = column_eigen_vectors(:, descending_eigen_values_index);

        % Leave out only specified amount of biggest eigenvectors
        descending_eigen_vectors = descending_eigen_vectors(:, 1:amount_of_biggest_eigen_vectors_to_leave);
        
    else
        % In this case the process can be speed up because all non-null
        % eigenvalues of scatter matrix can be found in a matrix of smaller
        % size: samples * (samples)' and according eigen vectors can be
        % found by (samples') * column_eigen_vectors.
        
        same_eigen_values_matrix = samples * (samples');
        
        % Find eigen values and vectors
        [column_eigen_vectors, diagonal_eigen_values] = eig( same_eigen_values_matrix );
        
        % Find eigen vectors of scatter matrix
        column_eigen_vectors = (samples') * column_eigen_vectors;
        
        % Sort eigenvalues in descending order
        [descending_eigen_values, descending_eigen_values_index] = sort(diag(diagonal_eigen_values), 'descend');

        % Sort eigenvectors accordingly
        descending_eigen_vectors = column_eigen_vectors(:, descending_eigen_values_index);

        % Leave out only specified amount of biggest eigenvectors
        descending_eigen_vectors = descending_eigen_vectors(:, 1:amount_of_biggest_eigen_vectors_to_leave);
        
    end
    
    % Normalize obtained vectors so that norm of each one is 1
    for i = 1:size(descending_eigen_vectors, 2)
        descending_eigen_vectors(:, i) = descending_eigen_vectors(:, i) / norm(descending_eigen_vectors(:, i));
    end
    
end

