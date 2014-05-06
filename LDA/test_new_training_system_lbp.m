
start_up_script;

%% Set up parameters

amount_of_biggest_eigen_vectors_to_use = 49;

amount_of_faces = 50;

amount_of_images_per_face = 10;

amount_of_images = amount_of_faces*amount_of_images_per_face;


%% Load training images and train system

load('../feature_vectors/similar_faces/LBP_feature_vectors.mat');

all_faces = lbp_similar_faces_feature_vectors;

image_size = size(lbp_similar_faces_feature_vectors, 2);

lables = zeros(1, amount_of_images);

% Create lables to get only elements for training. -1 - means that images
% is not included, other numbers designate classes of training images.

for current_faces_patch = 1:amount_of_faces
    
    for genuine_face_number = 1:5
        lables( (current_faces_patch-1)*10 + genuine_face_number ) = current_faces_patch;
    end
    
    for imposer_face_number = 1:5
        lables( (current_faces_patch-1)*10 + 5 + imposer_face_number ) = -1;
    end
    
end

mistakes_history = zeros( amount_of_faces*5, 2);

for current_face_patch_to_test = 1:amount_of_faces
   
    for number_of_imposer_to_include_in_training_set = 1:5
       
        new_lables = lables;
        
        new_lables( (current_face_patch_to_test-1)*10 + 5 + number_of_imposer_to_include_in_training_set ) = current_face_patch_to_test;
        
        [ training_faces, training_lables ] = image_manipulation.fetch_train_data_from_image_matrix( all_faces, new_lables );
        
        [ project_matrix, data_mean ] = face_rec_lib.Fisherfaces.create_fisherface_system( training_faces, training_lables, amount_of_biggest_eigen_vectors_to_use );
        
        fisherfaces_similar_faces_feature_vectors = face_rec_lib.Fisherfaces.project( project_matrix, all_faces, data_mean );
        
        pairwise_distance_matrix = image_manipulation.create_pairwise_distance_matrix( fisherfaces_similar_faces_feature_vectors, 'euclidean' );
        
        [ amount_of_mistakes, amount_of_possible_mistakes ] = image_manipulation.compute_amount_of_mistakes_in_distance_matrix( pairwise_distance_matrix, amount_of_faces, amount_of_images_per_face );
        
        mistakes_history( (current_face_patch_to_test-1)*5 + number_of_imposer_to_include_in_training_set, :) = [ amount_of_mistakes, amount_of_possible_mistakes ];
        
    end
    
end


