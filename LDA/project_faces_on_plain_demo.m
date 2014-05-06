
start_up_script;

%% Set up parameters

amount_of_biggest_eigen_vectors_to_use = 2;

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


[training_faces, lables] = image_manipulation.fetch_train_data_from_image_matrix( all_faces, lables );

[ project_matrix, data_mean ] = face_rec_lib.Fisherfaces.create_fisherface_system( training_faces, lables, amount_of_biggest_eigen_vectors_to_use );

fisherfaces_similar_faces_feature_vectors = face_rec_lib.Fisherfaces.project( project_matrix, all_faces, data_mean );

%% test

color_map = hsv(amount_of_faces);

hold on;

for i = 1:amount_of_faces
   
    for j = 1:5
        
        plot(fisherfaces_similar_faces_feature_vectors( (i-1)*10 + j, 1 ), fisherfaces_similar_faces_feature_vectors( (i-1)*10 + j, 2 ), 'color', color_map(i, :), 'Marker', 'o', 'markersize', 10, 'linewidth', 3);
        
    end
    
end

