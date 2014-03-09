
amount_of_biggest_eigen_vectors_to_use = 2;

number_of_face_to_represent_through_combination_of_eigen_faces = 6;

image_name_spec = '../aligned_cropped_faces_gray/%s.bmp';

face_size = size( imread('../aligned_cropped_faces_gray/1.bmp') );

mean_face = zeros(face_size(1), face_size(2), 'double');

training_faces = zeros( face_size(1) * face_size(2), 20, 'double');

%% Load all faces images

for i = 1:20

    str_number = int2str(i);
   
    image_file_name = sprintf(image_name_spec, str_number);
    
    face_image = double( imread(image_file_name) );
    
    mean_face = mean_face + face_image;
    
    training_faces(:, i) = double( reshape(face_image, [], 1) );
    
end

%% Compute mean face and normalize other faces

% Mean face creation
mean_face = mean_face / 20;

% From face image to face vector. Easier to work with
mean_face = reshape(mean_face, [], 1);

% Normalize other faces by subtracting the mean face. So that now expected
% values for each variable(pixel in this case) is 0
for i = 1:20
    training_faces(:, i) = training_faces(:, i) - mean_face;
end

%% Compute eigenvectors and eigenvalues of covariance matrix with optimized approach

% From this matrix eigenvalues and eigenvectors will be obtained
covarience_replacement = training_faces' * training_faces;

[eigen_vectors, eigen_values] = eig(covarience_replacement);

% Sort eigenvalues in descending order, so that it will be easier to omit
% vectors with small eigen values
[eigen_values_descend, eigen_values_descend_index] = sort(diag( eigen_values ), 'descend');

% Sort eigenvectors in the same way
eigen_vectors = eigen_vectors(:, eigen_values_descend_index);

% Obtain eigenvectors of covariance matrix
real_eigen_vectors = training_faces * eigen_vectors;

%% Represent one face as a combination of specified number of biggest eigenfaces

eigen_vectors_to_use = real_eigen_vectors(:, 1:amount_of_biggest_eigen_vectors_to_use);

% Create projecting matrix that consists of eigevectors that are placed in
% rows of this matrix
projecting_matrix = eigen_vectors_to_use';

% We are using normalized because to get to new coordinate system you also
% need to do translation i.e change system to new origin that is located in
% mean value of data
projected_data = projecting_matrix * training_faces(:, number_of_face_to_represent_through_combination_of_eigen_faces);

reconstructed_face = mean_face + ( eigen_vectors_to_use * projected_data );

% reconstructed_face = normalize_vector(reconstructed_face, 0, 255);
% 
% image_to_display = uint8( reshape(reconstructed_face, face_size(1), face_size(2)) );
% 
% imshow(image_to_display);

