function [ new_img ] = img2square_binary_patterns( img )
    %IMG2SQUARE_BINARY_PATTERNS Summary of this function goes here
    %   Detailed explanation goes here
    
    import face_rec_lib.LBP.get_matrix_element_value;
    
    rows_amount = size(img, 1);

    cols_amount = size(img, 2);

    new_img = zeros(rows_amount, cols_amount, 'uint8');

    % Binary numbers are computed for each pixel
    % Special function get_matrix_element_value() is used which returns 0 in
    % case of index outbound

    for i = 1:rows_amount
        for j = 1:cols_amount

            if get_matrix_element_value(img, i-1, j-1, 0) > img(i, j)
                new_img(i, j) = bitor(new_img(i, j), 1);
                % new_img(i, j) = new_img(i, j) + 1;
            end

            if get_matrix_element_value(img, i-1, j, 0) > img(i, j)
                new_img(i, j) = bitor(new_img(i, j), 2);
                % new_img(i, j) = new_img(i, j) + 2;
            end

            if get_matrix_element_value(img, i-1, j+1, 0) > img(i, j)
                new_img(i, j) = bitor(new_img(i, j), 4);
                % new_img(i, j) = new_img(i, j) + 4;
            end

            if get_matrix_element_value(img, i, j+1, 0) > img(i, j)
                new_img(i, j) = bitor(new_img(i, j), 8);
                % new_img(i, j) = new_img(i, j) + 8;
            end

            if get_matrix_element_value(img, i+1, j+1, 0) > img(i, j)
                new_img(i, j) = bitor(new_img(i, j), 16);
                % new_img(i, j) = new_img(i, j) + 16;
            end

            if get_matrix_element_value(img, i+1, j, 0) > img(i, j)
                new_img(i, j) = bitor(new_img(i, j), 32);
                % new_img(i, j) = new_img(i, j) + 32;
            end

            if get_matrix_element_value(img, i+1, j-1, 0) > img(i, j)
                new_img(i, j) = bitor(new_img(i, j), 64);
                % new_img(i, j) = new_img(i, j) + 64;
            end

            if get_matrix_element_value(img, i, j-1, 0) > img(i, j)
                new_img(i, j) = bitor(new_img(i, j), 128);
                % new_img(i, j) = new_img(i, j) + 128;
            end

        end
    end

end

