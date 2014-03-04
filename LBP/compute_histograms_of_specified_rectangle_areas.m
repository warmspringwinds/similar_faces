function [ histograms ] = compute_histograms_of_specified_rectangle_areas(  matrix, row_indexes, column_indexes, histogram_values )
    % Computes histograms for each of the specified rectangular submatrixes of original matrix
    % Input:
    % @matrix - matrix in which specified submatrixes are located
    % @row_indexes - matrix containing [begin_of_submatrix, end_of_submatrix] 
    % indexes of row_idexes. The order in which indexes are presented determines
    % the number of submatrix and output histograms will be in the same order 
    % @column_indexes - the same for columns
    % @histogram_values - range to be used with created histograms.
    % See xvalues parameter for hist() matlab function
    % Output:
    % @histograms - output histograms. N-th row of matrix - histogram 
    % computed for n-th input submatrix
    
    amount_of_histograms = size(row_indexes, 1);
    histograms = zeros(amount_of_histograms*amount_of_histograms, 10);

    for i = 1:amount_of_histograms
        for j = 1:amount_of_histograms
          
            row_range_of_current_box = row_indexes(i, 1):row_indexes(i, 2);
            column_range_of_current_box = column_indexes(j, 1):column_indexes(j, 2);
            current_box = matrix(row_range_of_current_box, column_range_of_current_box);
            histograms(amount_of_histograms*(i-1) + j, :) = hist(current_box(:), histogram_values);
        end
    end

end

