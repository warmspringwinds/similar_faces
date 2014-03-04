function [ return_value ] = get_matrix_element_value( matrix, row_index, col_index, default_value)
    % Get matrix value function extended with default value in
    % case of index out of bounds
    
    return_value = default_value;
    
    rows_amount = size(matrix, 1);
    cols_amount = size(matrix, 2);
    
    if ( (row_index) > 0 ) && ( (row_index) <= rows_amount )
            if ( (col_index) > 0 ) && ( (col_index) <= cols_amount )
                return_value = matrix(row_index, col_index);
            end
    end

end

