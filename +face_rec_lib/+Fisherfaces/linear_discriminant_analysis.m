function [ descending_eigen_vectors, overall_mean ] = linear_discriminant_analysis( samples, lables, amount_of_biggest_eigen_vectors_to_leave )
    %   Carries out Linear Discriminant Analysis on specified sample data
    %   Creates new system where elements of each class are placed as close
    %   as possible and elements of different classes are placed as far as
    %   possible.
    %   Input:
    %   @samples - Matrix where rows are samples
    %   @lables - Array which lables each sample in @samples according to
    %   class that this sample belongs to
    %   @amount_of_biggest_eigen_vectors_to_leave - the size of the new
    %   coordinate system. The max size is c - 1 where c is the amount of
    %   classes
    %   Output:
    %   @descending_eigen_vectors - coordinate axes of the new system which
    %   are placed in columns of @descending_eigen_vectors
    %   @overall_mean - mean of sample data. Used to subtract from data
    %   samples before projecting into new coordinate system
    
    [sample_amount, sample_dimension] = size( samples );

    classes = unique( lables );

    classes_amount = length( classes );

    overall_mean = mean( samples );

    between_class_scatter = zeros( sample_dimension );
    within_class_scatter = zeros( sample_dimension );

    for current_class = 1:classes_amount

        % Get all samples of current class
        current_class_samples = samples( find(lables == classes(current_class)), : );

        amount_of_current_class_samples = size(current_class_samples, 1);

        current_class_mean = mean( current_class_samples );

        % Subtract mean of current class from each sample
        current_class_samples_normalized = current_class_samples - repmat(current_class_mean, amount_of_current_class_samples, 1);

        % Add current within and between class scatter to overall ones
        within_class_scatter = within_class_scatter + ( (current_class_samples_normalized') * current_class_samples_normalized );

        between_class_scatter = between_class_scatter + ...
            ( amount_of_current_class_samples * (current_class_mean - overall_mean)' * (current_class_mean - overall_mean) );

    end

    % Solve generalized eigenvalues problem
    [column_eigen_vectors, diagonal_eigen_values] = eig( between_class_scatter, within_class_scatter);
    
    % Sort eigenvalues in descending order
    [descending_eigen_values, descending_eigen_values_index] = sort(diag(diagonal_eigen_values), 'descend');

    % Sort eigenvectors accordingly
    descending_eigen_vectors = column_eigen_vectors(:, descending_eigen_values_index);
    
    % Leave out only specified amount of biggest eigenvectors
    descending_eigen_vectors = descending_eigen_vectors(:, 1:amount_of_biggest_eigen_vectors_to_leave);

end

