% Script to compute simple square (not circular) 8-bit binary patterns for each
% pixel of image and then leave only non-uniform patterns
% Goal of this section is to show that amount of non-uniform patterns is
% comparatively small.
% Values 1-9 are uniform patterns (at most 2 0/1 or 1/0 bit changes) 
% 10 are non-uniform 

%% Compute binary patterns for image
 
% Load precomputer look-up table of binary patterns
load('8bit_binary_patterns_look_up_table.mat');

% Variable where the table is stored
eight_bit_binary_patterns_table;

% img = rgb2gray( imread('kids.tif') );

img = imread('../aligned_cropped_faces_gray/6.bmp');

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
        
        new_img(i, j) = eight_bit_binary_patterns_table(new_img(i, j) + 1);
        
    end
end

%% Display original image + results

figure, imshow(img)
title('Original image');

% Multiplied by 20 to enchance contrast.
figure, imshow(new_img*20);
title('Binary patterns presentation of face')

% Only non uniform patterns left.
non_uniform_patterns_only = new_img;
non_uniform_patterns_only(new_img ~= 10) = 0;
figure, imshow(non_uniform_patterns_only*255);
title('Non uniform patterns amount')
