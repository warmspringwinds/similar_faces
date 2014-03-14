% Script to create feature vectors out of gray-scale cropped and aligned
% faces and save it to a .mat file for future use.

start_up_script;

image_name_spec = '../aligned_cropped_faces_gray/%s.bmp';

circular_radius = 2;
amount_of_blocks_for_histogram_on_each_axis = 7;
amount_of_faces = 20;

load('8bit_uniform_binary_patterns_look_up_table.mat');

% Variable where the table is stored
eight_bit_binary_patterns_table;

% Size of one feature vector = (amount of blocks that image were broken
% into)^2 * amount of all possible local binary patterns. Amount of all
% local binary patterns is 10 because they are uniform 8bit binary
% patterns.
size_of_one_feature_vector = amount_of_blocks_for_histogram_on_each_axis^2 * 10;

lbp_japan_women_feature_vectors = zeros(20, size_of_one_feature_vector);

for i = 1:20

    str_number = int2str(i);
   
    image_file_name = sprintf(image_name_spec, str_number);
    
    image = imread(image_file_name);
    
    feature_vector = ...
                     face_rec_lib.LBP.create_feature_vector_using_circular_8bit_unifrom_patterns( ...
                     image, circular_radius, amount_of_blocks_for_histogram_on_each_axis, eight_bit_binary_patterns_table);
    
    %lbp_feature_vectors(i, :) = ( create_feature_vector_using_8bit_unifrom_bin_patterns(image, circular_radius, amount_of_blocks_for_histogram_on_each_axis) )';

    lbp_japan_women_feature_vectors(i, :) = feature_vector';
    
end

save('../feature_vectors/japan_women/LBP_feature_vectors.mat', 'lbp_japan_women_feature_vectors');
