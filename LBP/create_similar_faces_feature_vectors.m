% Script that demonstrates eigenfaces work. Selected face is presented as a
% combination of found eigenfaces.

start_up_script;

%% Set up parameters

circular_radius = 2;
amount_of_blocks_for_histogram_on_each_axis = 13;

%% Load all faces images

image_path = '../similar_faces_db/Lookalike_Final_Publish_v6.0/aligned_cropped_gray/';

img_list = dir([image_path, '*.bmp']);

amount_of_faces = size(img_list, 1);

load('8bit_uniform_binary_patterns_look_up_table.mat');

% Variable where the table is stored
eight_bit_binary_patterns_table;

% Size of one feature vector = (amount of blocks that image were broken
% into)^2 * amount of all possible local binary patterns. Amount of all
% local binary patterns is 10 because they are uniform 8bit binary
% patterns.
size_of_one_feature_vector = amount_of_blocks_for_histogram_on_each_axis^2 * 10;

% Load faces images

lbp_similar_faces_feature_vectors = zeros(amount_of_faces, size_of_one_feature_vector);



for i = 1:amount_of_faces
    
    img_name = img_list(i).name;
    
    image = double( imread([ image_path, img_name ]) );
    
    feature_vector = ...
                     face_rec_lib.LBP.create_feature_vector_using_circular_8bit_unifrom_patterns( ...
                     image, circular_radius, amount_of_blocks_for_histogram_on_each_axis, eight_bit_binary_patterns_table);

    lbp_similar_faces_feature_vectors(i, :) = feature_vector';
    
end

save('../feature_vectors/similar_faces/LBP_feature_vectors.mat', 'lbp_similar_faces_feature_vectors');