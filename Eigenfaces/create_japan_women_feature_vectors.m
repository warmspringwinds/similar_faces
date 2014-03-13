% Script to create feature vectors out of provided face images

%% Set up parameters

amount_of_biggest_eigen_vectors_to_use = 9;

image_name_spec = '../aligned_cropped_faces_gray/%s.bmp';

sample_face_image = imread( sprintf(image_name_spec, ...
         int2str( 1 ) ) );

face_size = size( sample_face_image );

training_faces = zeros( face_size(1) * face_size(2), 20, 'double');

%% Load all faces images

for i = 1:20

    str_number = int2str(i);
   
    image_file_name = sprintf(image_name_spec, str_number);
    
    face_image = double( imread(image_file_name) );
    
    training_faces(:, i) = reshape(face_image, [], 1);
    
end

[ mean_face, faces_difference_vectors, eigen_faces_vectors_descend, eigen_values_descend ] = create_eigenface_system(training_faces);

%% Compute the ratio of data that we will save

% In this case with the amount of 9 eigenvectors about 86 amount of data is
% saved

data_loss_ratio = sum(eigen_values_descend(1:amount_of_biggest_eigen_vectors_to_use)) / sum(eigen_values_descend);


%% Represent faces as a combination of specified number of biggest eigenfaces

eigen_vectors_to_use = eigen_faces_vectors_descend(:, 1:amount_of_biggest_eigen_vectors_to_use);

% Create projecting matrix that consists of eigevectors that are placed in
% rows of this matrix
projecting_matrix = eigen_vectors_to_use';

% We are using normalized face vectors because to get to new coordinate system you also
% need to do translation i.e change system to new origin that is located in
% mean value of data

% Get projection. In this case they will be used as feature vectors.
eigenfaces_feature_vectors = projecting_matrix * faces_difference_vectors;

% This is done to follow common style for saving feature vectors
% Each row is a feature vector for corresponding face 
eigenfaces_japan_women_feature_vectors = eigenfaces_feature_vectors';

save('Eigenfaces_japan_women_feature_vectors.mat', 'eigenfaces_japan_women_feature_vectors');


