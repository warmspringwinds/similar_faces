% Script to compute simple square (not circular) 8-bit binary patterns for each
% pixel of image and then leave only non-uniform patterns
% Goal of this section is to show that amount of non-uniform patterns is
% comparatively small.
% Values 1-9 are uniform patterns (at most 2 0/1 or 1/0 bit changes) 
% 10 are non-uniform 

%% Compute binary patterns for image

start_up_script;

% Load precomputer look-up table of binary patterns
load('8bit_uniform_binary_patterns_look_up_table.mat');

% Variable where the table is stored
eight_bit_binary_patterns_table;

% img = rgb2gray( imread('kids.tif') );

img = imread('../aligned_cropped_faces_gray/6.bmp');

new_img = face_rec_lib.LBP.img2square_binary_patterns( img );

% Create uniform rotation invariant binary patterns with
% the help of precomputed look-up table.
new_img = intlut(new_img, eight_bit_binary_patterns_table);

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
