function [ result_img ] = img2circular_binary_patterns(img, radius, circular_points_amount)
    % Computes circular binary patterns of image. These values are not yet
    % rotation invariant. They are only monotone luminance change
    % invariant. In order to achieve rotation invariance, you also need to
    % assign every pattern that can be created by rotating the original
    % one to one number. Example: 01100000 and 00110000 should be assined
    % to one number.
    % 
    % Input:
    % @radius - radius of circular pattern. The greater the number the
    % bigger details can be captured, but smaller details will be lost.
    % @circular_points_amount - amounts of points that will be equally
    % spaces along the circle with specified radius
    % @img - gray-scale image to be processed
    % Output:
    % result_img - output img. The size of this matrix will be 2*radius
    % smaller in width and in height.
    
    rows_amount = size(img, 1);

    cols_amount = size(img, 2);

    % Size of result image will be smaller!
    % TODO: change uint8 because when number of circular points is more than
    % 8 the values of matrix overflow.
    result_img = zeros(rows_amount - 2*radius, cols_amount - 2*radius, 'uint8');

    for circular_point_number = 0:circular_points_amount-1

        % Optimization: compute x and y once for each circular point and then
        % apply it for each pixel of image.

        x = radius*cos( (2*pi/circular_points_amount) * circular_point_number);
        y = radius*sin( (2*pi/circular_points_amount) * circular_point_number);

        floor_x = floor(x);
        floor_y = floor(y);

        ceil_x = ceil(x);
        ceil_y = ceil(y);

        % Fractional part
        frac_x = x - floor_x;
        frac_y = y - floor_y;

        % Bipolar interpolation weights
        weight_1 = (1 - frac_x) * (1 - frac_y);
        weight_2 = frac_x * (1 - frac_y);
        weight_3 = (1 - frac_x) * frac_y;
        weight_4 = frac_x * frac_y;

        for i = radius+1:rows_amount-radius
            for j = radius+1:cols_amount-radius

                interpolated_pixel_value = weight_1*img(i+floor_y, j+floor_x) + ...
                                           weight_2*img(i+floor_y, j+ceil_x)  + ...
                                           weight_3*img(i+ceil_y, j+floor_x)  + ...
                                           weight_4*img(i+ceil_y, j+ceil_x);

                if interpolated_pixel_value >= img(i,j)
                    result_img(i-radius, j-radius) = result_img(i-radius, j-radius) +  bitshift(1, circular_point_number);
                end

            end
        end

    end
    
end

