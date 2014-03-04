function [ row_matrix_indexes, column_matrix_indexes ] = split_matrix_into_equal_regions( matrix_size, amount_of_regions_on_each_axis )
    % Tries to split matrix into amount_of_regions_on_each_axis^2 matrices of equal size.
    % If amount of rows and amount of columns are divisible by amount of
    % regions, this function will return amount_of_regions_on_each_axis^2 
    % idexes of equal matrices. Otherwise, it will be an approximation.
    % If this is not possible some matrices will be a bit bigger.
    % Input:
    % @matrix_size - matrix size to be splitted [rows_amount, columns_amount]
    % @amount_of_regions_on_each_axis - split matrix into
    % amount_of_regions_on_each_axis^2 matrices
    % Output:
    % @row_matrix_indexes - matrix of size (amount_of_regions_on_each_axis, 2)
    % (amount_of_regions_on_each_axis, 1) is the beginning of the region, (amount_of_regions_on_each_axis, 1)
    % is the end of the region.
    % @column_matrix_indexes - the same but for columns
    
    row_matrix_indexes = zeros(amount_of_regions_on_each_axis, 2);
    column_matrix_indexes = zeros(amount_of_regions_on_each_axis, 2);
    
    row_amount = matrix_size(1);
    column_amount = matrix_size(2);

    row_indexes = round( linspace(0, row_amount, amount_of_regions_on_each_axis + 1) );
    column_indexes = round( linspace(0, column_amount, amount_of_regions_on_each_axis + 1) );
    
    for i = 1:amount_of_regions_on_each_axis
                
        row_sector = [ row_indexes(i)+1 row_indexes(i+1) ];
        column_sector = [ column_indexes(i)+1 column_indexes(i+1) ];
        
        row_matrix_indexes(i, :) = row_sector;
        column_matrix_indexes(i, :) = column_sector;
        
    end

end

