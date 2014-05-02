function [ project_matrix, mean ] = create_fisherface_system( samples, lables, amount_of_biggest_eigen_vectors_to_leave )
    % Creates fisherfaces sysmtem which combines PCA and LDA. In the output
    % there are project matrix and mean with the help of which it is
    % possible to project any data into new coordinate system.
    % Input:
    % @samples - matrix where each row is a data sample
    % @lables - array which marks each data row with according lable which
    % specifies the class to which the data sample belongs to
    % @amount_of_biggest_eigen_vectors_to_leave - the size of output
    % coordinate system which has max at class_amount - 1
    % Output:
    % @prject_matrix - matrix to project any data sample into new
    % coordinate system by multiplying @sample-like data sample on the
    % right. You should also subtract @mean from @sample-like data matrix
    % @mean - mean of data matrix which is subtracted from data samples
    % before projecting
    
    
    % Load help functions
    import face_rec_lib.Fisherfaces.*;
    
    [sample_amount, sample_dimension] = size( samples );
    
    classes = unique( lables );

    classes_amount = length( classes );
    
    % Max amount of axes is classes_amount - 1
    amount_of_biggest_eigen_vectors_to_leave = min( amount_of_biggest_eigen_vectors_to_leave, classes_amount - 1 );
    
    % Reduce dimension to sample_amount - classes_amount in order to be
    % able to apply linear discriminant analysis.
    [pca_project_matrix, pca_mean] = principal_component_analysis( samples, sample_amount - classes_amount );
    
    reduced_dimension_data = project( pca_project_matrix, samples, pca_mean);
    
    [lda_project_matrix, lda_mean] = linear_discriminant_analysis( reduced_dimension_data, lables, amount_of_biggest_eigen_vectors_to_leave );
    
    project_matrix = pca_project_matrix * lda_project_matrix;
    
    mean = pca_mean;


end

