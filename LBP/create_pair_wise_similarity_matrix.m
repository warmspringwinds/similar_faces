% Script that creates matrix of similarity between each feature vector
% representing corresponding face. In this example chi squared distance is
% used.
start_up_script;

load('LBP_feature_vectors.mat');

lbp_feature_vectors = double(lbp_feature_vectors);

amount_of_vectors = size(lbp_feature_vectors, 1);

pairwise_distance_matrix = zeros(amount_of_vectors);

for i = 1:amount_of_vectors
    for j = 1:amount_of_vectors
        pairwise_distance_matrix(i, j) = face_rec_lib.LBP.chi_squared_distance(lbp_feature_vectors(i, :), lbp_feature_vectors(j, :));
    end
end

imagesc(pairwise_distance_matrix);
colorbar;


