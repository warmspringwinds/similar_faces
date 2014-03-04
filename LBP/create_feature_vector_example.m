%% Compute uniform LBP from image and split it

% Amount of blocks on each axis. It will be k*k blocks.
k = 5;

% Radius of rotation invariant LBP
radius = 2;

% Amount of circular point on LBP
% Cannot be changed: not implemented yet
circular_points = 8;

% Load precomputer look-up table of rotation invariant uniform binary patterns
load('8bit_uniform_binary_patterns_look_up_table.mat');

% Variable where the table is stored
eight_bit_binary_patterns_table;

img = imread('../aligned_cropped_faces_gray/7.bmp');

% Simple LBP without rotation invariance
plain_circular_binary_patterns = img2circular_binary_patterns(img, radius, circular_points);

% Create uniform rotation invariant binary patterns with
% the help of precomputed look-up table.
converted_img = intlut(plain_circular_binary_patterns, eight_bit_binary_patterns_table);

% Indexes to split LBP image
[row_indexes, column_indexes] = split_matrix_into_equal_regions(size(converted_img), k);

%% Display how is the image splitted

% Converted image with enchanced contrast for displaying purposes
converted_img_dummy = converted_img*10;

for i = 1:k
    % Splitting lines will be white
    converted_img_dummy(row_indexes(i, 1), :) = 255;
end

for i = 1:k
    converted_img_dummy(:, column_indexes(i, 1)) = 255;
end

figure, imshow(img);
title('Original image');

figure, imshow(converted_img_dummy);
title('LBP image splitted into blocks');

%% Compute histogram for each region and dislplay it

% Ten values - because patterns are uniform
histogram_range = 1:10;

% Creat histograms. Each row - histogram for region
face_features = compute_histograms_of_specified_rectangle_areas(converted_img, row_indexes, column_indexes, histogram_range);

% Show histogram for each region
for i = 1:k
    for j = 1:k
        subplot(k, k, k*(i-1) + j), bar(face_features(k*(i-1) + j, :));
    end
end

% Concatenate rows into one feature vector
face_features_vector = reshape(face_features.', [], 1);







