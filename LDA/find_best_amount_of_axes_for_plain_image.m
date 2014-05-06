% After carrying out experiments it was found that the amount of
% eigenvectors that minimizes the mistake is 36.

start_up_script;

%% Set up parameters

max_amount_of_biggest_eigen_vectors_to_use = 49;

amount_of_images_per_face = 10;

amount_of_faces = 50;


min_amount_of_found_mistakes = Inf;
amount_of_eigen_vectors_that_minimizes_mistake = -1;

%% Load training images and train system

images_path = '../similar_faces_db/Lookalike_Final_Publish_v6.0/aligned_cropped_gray/';
images_regex = '*.bmp';

[all_faces, image_size, amount_of_images] = image_manipulation.load_images_in_matrix_rows(images_path, images_regex);

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



[ training_faces, training_lables ] = image_manipulation.fetch_train_data_from_image_matrix( all_faces, lables );

for amount_of_eigen_vectors_to_test = 1:max_amount_of_biggest_eigen_vectors_to_use
         
    [ project_matrix, data_mean ] = face_rec_lib.Fisherfaces.create_fisherface_system( training_faces, training_lables, amount_of_eigen_vectors_to_test );

    fisherfaces_similar_faces_feature_vectors = face_rec_lib.Fisherfaces.project( project_matrix, all_faces, data_mean );

    pairwise_distance_matrix = image_manipulation.create_pairwise_distance_matrix( fisherfaces_similar_faces_feature_vectors, 'euclidean' );

    [ amount_of_mistakes, amount_of_possible_mistakes ] = image_manipulation.compute_amount_of_mistakes_in_distance_matrix( pairwise_distance_matrix, amount_of_faces, amount_of_images_per_face );
    
    if min_amount_of_found_mistakes > amount_of_mistakes
        
        min_amount_of_found_mistakes = amount_of_mistakes;
        amount_of_eigen_vectors_that_minimizes_mistake = amount_of_eigen_vectors_to_test;
    end
    
end

