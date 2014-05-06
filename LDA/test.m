% Script that demonstrates eigenfaces work. Selected face is presented as a
% combination of found eigenfaces.

start_up_script;

%% Set up parameters

amount_of_biggest_eigen_vectors_to_use = 36;

amount_of_faces = 50;


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

lables(6) = 1;

[training_faces, lables] = image_manipulation.fetch_train_data_from_image_matrix( all_faces, lables );

[ project_matrix, data_mean ] = face_rec_lib.Fisherfaces.create_fisherface_system( training_faces, lables, amount_of_biggest_eigen_vectors_to_use );

%% Load all images and get their features

fisherfaces_similar_faces_feature_vectors = face_rec_lib.Fisherfaces.project( project_matrix, all_faces, data_mean );

save('../feature_vectors/similar_faces/Fisherfaces_feature_vectors_2.mat', 'fisherfaces_similar_faces_feature_vectors');



