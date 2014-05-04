% Script that demonstrates eigenfaces work. Selected face is presented as a
% combination of found eigenfaces.

start_up_script;

%% Set up parameters

amount_of_biggest_eigen_vectors_to_use = 35;

%% Load training images and train system

images_path = '../similar_faces_db/Lookalike_Final_Publish_v6.0/aligned_cropped_gray/';
images_regex = '*gen*.bmp';

% 
% img_list = dir([image_path, '*gen*.bmp']);
% 
% amount_of_training_faces = size(img_list, 1);
% 
% sample_face_image_name = img_list(sample_face_number).name;
% 
% sample_face_image = imread([ image_path, sample_face_image_name ]);
% 
% face_size = size( sample_face_image );
% 
% training_faces = zeros( amount_of_training_faces, face_size(1) * face_size(2), 'double');
% 
% lables = zeros(1, amount_of_training_faces );
% 
% for i = 1:amount_of_training_faces
%     
%     img_name = img_list(i).name;
%     
%     face_image = double( imread([ image_path, img_name ]) );
%     
%     training_faces(i, :) = reshape(face_image, 1, []);
%     
%     % Each class contains 5 images
%     lables(i) = floor( i/5 );
%     
% end

[training_faces, image_size, amount_of_images] = image_manipulation.load_images_in_matrix_rows(images_path, images_regex);

lables = zeros(1, amount_of_images);

for i = 1:amount_of_images
    lables(i) = floor( (i-1)/5 );
end

[ project_matrix, data_mean ] = face_rec_lib.Fisherfaces.create_fisherface_system( training_faces, lables, amount_of_biggest_eigen_vectors_to_use );

%% Load all images and get their features

images_regex = '*.bmp';

all_faces = image_manipulation.load_images_in_matrix_rows(images_path, images_regex);

fisherfaces_similar_faces_feature_vectors = face_rec_lib.Fisherfaces.project( project_matrix, all_faces, data_mean );

save('../feature_vectors/similar_faces/Fisherfaces_feature_vectors.mat', 'fisherfaces_similar_faces_feature_vectors');



