% Script to create feature vectors out of gray-scale 
% and save it to a .mat file for future use.

start_up_script;

image_name_spec = '../aligned_cropped_faces_gray/%s.bmp';

circular_radius = 2;
amount_of_blocks_for_histogram_on_each_axis = 30;
number_of_people = 10;

% Naming convention changes after 5th face image
% First substituted value - number of person, second - illumination
% parameter
image_name_spec_1 = '../mit_faces/training-synthetic/000%s_0_0_0_15_%s_1.pgm';
image_name_spec_2 = '../mit_faces/training-synthetic/000%s_0_0_0_0_15_%s_1.pgm';

load('8bit_uniform_binary_patterns_look_up_table.mat');

% Variable where the table is stored
eight_bit_binary_patterns_table;

% Size of one feature vector = (amount of blocks that image were broken
% into)^2 * amount of all possible local binary patterns. Amount of all
% local binary patterns is 10 because they are uniform 8bit binary
% patterns.
size_of_one_feature_vector = amount_of_blocks_for_histogram_on_each_axis^2 * 10;

% Load faces images

lbp_mit_artificial_feature_vectors = zeros(number_of_people*6, size_of_one_feature_vector);

for i = 0:number_of_people-1

    str_number = int2str(i);
    
    if i < 6
        image_name_spec = image_name_spec_1;
    else
        image_name_spec = image_name_spec_2;
    end
    
    % 6 types of different illumination. Can be used more
    for illumination = 0:5
        
        image_file_name = sprintf(image_name_spec, str_number, int2str( illumination * 15 ));
    
        face_image = double( imread(image_file_name) );
        
        feature_vector = ...
                     face_rec_lib.LBP.create_feature_vector_using_circular_8bit_unifrom_patterns( ...
                     face_image, circular_radius, amount_of_blocks_for_histogram_on_each_axis, eight_bit_binary_patterns_table);
    
                 
        lbp_mit_artificial_feature_vectors(i*6 + (illumination+1), :) = feature_vector';

    end
end

save('../feature_vectors/mit_artificial_faces/LBP_feature_vectors.mat', 'lbp_mit_artificial_feature_vectors');
