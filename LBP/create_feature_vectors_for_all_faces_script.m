% Script to create feature vectors out of gray-scale cropped and aligned
% faces and save it to a .mat file for future use.

image_name_spec = '../aligned_cropped_faces_gray/%s.bmp';

circular_radius = 2;
amount_of_blocks_for_histogram_on_each_axis = 7;
amount_of_faces = 20;

% Size of one feature vector = (amount of blocks that image were broken
% into)^2 * amount of all possible local binary patterns. Amount of all
% local binary patterns is 10 because they are uniform 8bit binary
% patterns.
size_of_one_feature_vector = amount_of_blocks_for_histogram_on_each_axis^2 * 10;

lbp_feature_vectors = zeros(20, size_of_one_feature_vector);

for i = 1:20

    str_number = int2str(i);
   
    image_file_name = sprintf(image_name_spec, str_number);
    
    image = imread(image_file_name);
    
    lbp_feature_vectors(i, :) = ( create_feature_vector_using_8bit_unifrom_bin_patterns(image, circular_radius, amount_of_blocks_for_histogram_on_each_axis) )';
    
end

save('LBP_feature_vectors.mat','lbp_feature_vectors');
