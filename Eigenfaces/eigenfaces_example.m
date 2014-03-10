% Script that demonstrates eigenfaces work. Selected face is presented as a
% combination of found eigenfaces.

%% Set up parameters

amount_of_biggest_eigen_vectors_to_use = 20;

number_of_face_to_represent_through_combination_of_eigen_faces = 6;

image_name_spec = '../aligned_cropped_faces_gray/%s.bmp';

original_image_to_represent = imread( sprintf(image_name_spec, ...
         int2str( number_of_face_to_represent_through_combination_of_eigen_faces) ) );

face_size = size( original_image_to_represent );

training_faces = zeros( face_size(1) * face_size(2), 20, 'double');

%% Load all faces images

for i = 1:20

    str_number = int2str(i);
   
    image_file_name = sprintf(image_name_spec, str_number);
    
    face_image = double( imread(image_file_name) );
    
    training_faces(:, i) = reshape(face_image, [], 1);
    
end

[ mean_face, faces_difference_vectors, eigen_faces_vectors_descend, eigen_values_descend ] = create_eigenface_system(training_faces);


%% Represent one face as a combination of specified number of biggest eigenfaces

eigen_vectors_to_use = eigen_faces_vectors_descend(:, 1:amount_of_biggest_eigen_vectors_to_use);

% Create projecting matrix that consists of eigevectors that are placed in
% rows of this matrix
projecting_matrix = eigen_vectors_to_use';

% We are using normalized face vectors because to get to new coordinate system you also
% need to do translation i.e change system to new origin that is located in
% mean value of data
projected_data = projecting_matrix * faces_difference_vectors(:, number_of_face_to_represent_through_combination_of_eigen_faces);

reconstructed_face = mean_face + ( eigen_vectors_to_use * projected_data );

%% Display reconstructed face and original face

image_to_display = uint8( reshape(reconstructed_face, face_size(1), face_size(2)) );

figure, imshow(image_to_display);
title('Reconstructed image');

figure, imshow(original_image_to_represent);
title('Original image');
