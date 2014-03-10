% Script that creates matrix of similarity between each feature vector
% representing corresponding face. In this example Euclidean distance is
% used.

load('Eigenfaces_feature_vectors.mat');

% Name of the loaded matrix with feature vectors
eigenfaces_feature_vectors;

amount_of_vectors = size(eigenfaces_feature_vectors, 1);

pairwise_distance_matrix = zeros(amount_of_vectors);

for i = 1:amount_of_vectors
    for j = 1:amount_of_vectors
        pairwise_distance_matrix(i, j) = norm( eigenfaces_feature_vectors(i, :) - eigenfaces_feature_vectors(j, :) );
    end
end

imagesc(pairwise_distance_matrix);
colorbar;
