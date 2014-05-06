% Script that creates matrix of similarity between each feature vector
% representing corresponding face. In this example Euclidean distance is
% used.

%% Compute pair-wise distance matrix

start_up_script;

load('../../feature_vectors/similar_faces/Fisherfaces_feature_vectors.mat');

% Name of the loaded matrix with feature vectors
feature_vectors = fisherfaces_similar_faces_feature_vectors;

pairwise_distance_matrix = image_manipulation.create_pairwise_distance_matrix(feature_vectors, 'euclidean');

%% Display matrix

imagesc(pairwise_distance_matrix);
colorbar;

%% Compute amount of mistakes

amount_of_images_per_face = 10;
amount_of_faces = 50;

[ amount_of_mistakes, amount_of_possible_mistakes ] = image_manipulation.compute_amount_of_mistakes_in_distance_matrix( pairwise_distance_matrix, amount_of_faces, amount_of_images_per_face );

