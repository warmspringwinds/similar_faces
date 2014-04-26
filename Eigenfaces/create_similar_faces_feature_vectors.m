% Script that demonstrates eigenfaces work. Selected face is presented as a
% combination of found eigenfaces.

start_up_script;

%% Set up parameters

amount_of_biggest_eigen_vectors_to_use = 250;

sample_face_number = 4;

%% Load all faces images

image_path = '../similar_faces_db/Lookalike_Final_Publish_v6.0/aligned_cropped_gray/';

img_list = dir([image_path, '*.bmp']);

amount_of_training_faces = size(img_list, 1);

sample_face_image_name = img_list(sample_face_number).name;

sample_face_image = imread([ image_path, sample_face_image_name ]);

face_size = size( sample_face_image );

training_faces = zeros( face_size(1) * face_size(2), amount_of_training_faces, 'double');

for i = 1:amount_of_training_faces
    
    img_name = img_list(i).name;
    
    face_image = double( imread([ image_path, img_name ]) );
    
    training_faces(:, i) = reshape(face_image, [], 1);
    
end

[ mean_face, faces_difference_vectors, eigen_faces_vectors_descend, eigen_values_descend ] = face_rec_lib.Eigenfaces.create_eigenface_system(training_faces);

%% Compute the ratio of data that we will save

data_preserve_ratio = sum(eigen_values_descend(1:amount_of_biggest_eigen_vectors_to_use)) / sum(eigen_values_descend)

%% Represent one face as a combination of specified number of biggest eigenfaces

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
eigenfaces_similar_faces_feature_vectors = eigenfaces_feature_vectors';

save('../feature_vectors/similar_faces/Eigenfaces_feature_vectors.mat', 'eigenfaces_similar_faces_feature_vectors');
