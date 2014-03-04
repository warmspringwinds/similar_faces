%% Compute matrix with circular binary uniform patterns with radius 2 and 8 points

% Load precomputer look-up table of rotation invariant uniform binary patterns
load('8bit_uniform_binary_patterns_look_up_table.mat');

% Variable where the table is stored
eight_bit_binary_patterns_table;

radius = 2;
circular_points = 8;

img = imread('../aligned_cropped_faces_gray/6.bmp');

plain_circular_binary_patterns = img2circular_binary_patterns(img, radius, circular_points);

% Create uniform rotation invariant binary patterns with
% the help of precomputed look-up table.
rotation_invariant_uniform_binary_patterns = intlut(plain_circular_binary_patterns, eight_bit_binary_patterns_table);

%% Display result and statistics

figure, imshow(img);
title('Original image');

figure, imshow(plain_circular_binary_patterns);
title('Plain circular binary patterns');

% Multiplid by 25 to enchance contrast
figure, imshow(rotation_invariant_uniform_binary_patterns*25);
title('Rotation invariant uniform binary patterns');

% Dislplay only non-uniform patterns. They are marked with white color.
non_uniform_patterns = rotation_invariant_uniform_binary_patterns;
non_uniform_patterns(rotation_invariant_uniform_binary_patterns ~= 10) = 0;
figure, imshow(non_uniform_patterns*25)
title('Only non-uniform patterns');

% Amount of non-uniform patterns in images of faces is about 0.07
amount_of_all_patterns = numel(rotation_invariant_uniform_binary_patterns);
amount_of_non_uniform_patterns = sum(sum( rotation_invariant_uniform_binary_patterns == 10 ));

ratio = amount_of_non_uniform_patterns / amount_of_all_patterns
