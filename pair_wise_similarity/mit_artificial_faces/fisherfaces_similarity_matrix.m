% Script that creates matrix of similarity between each feature vector
% representing corresponding face. In this example Euclidean distance is
% used.

%% Compute pair-wise distance matrix

start_up_script;

load('../../feature_vectors/mit_artificial_faces/Fisherfaces_feature_vectors.mat');

% Name of the loaded matrix with feature vectors
fisherfaces_feature_vectors = fisherfaces_mit_artificial_feature_vectors;

amount_of_vectors = size(fisherfaces_feature_vectors, 1);

pairwise_distance_matrix = zeros(amount_of_vectors);

for i = 1:amount_of_vectors
    for j = 1:amount_of_vectors
        pairwise_distance_matrix(i, j) = norm( fisherfaces_feature_vectors(i, :) - fisherfaces_feature_vectors(j, :) );
    end
end

%% Display matrix

imagesc(pairwise_distance_matrix);
colorbar;