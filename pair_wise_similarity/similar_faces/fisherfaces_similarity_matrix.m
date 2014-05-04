% Script that creates matrix of similarity between each feature vector
% representing corresponding face. In this example Euclidean distance is
% used.

%% Compute pair-wise distance matrix

start_up_script;

load('../../feature_vectors/similar_faces/Fisherfaces_feature_vectors.mat');

% Name of the loaded matrix with feature vectors
feature_vectors = fisherfaces_similar_faces_feature_vectors;

amount_of_vectors = size(feature_vectors, 1);

pairwise_distance_matrix = zeros(amount_of_vectors);

for i = 1:amount_of_vectors
    for j = 1:amount_of_vectors
        pairwise_distance_matrix(i, j) = norm( feature_vectors(i, :) - feature_vectors(j, :) );
    end
end

%% Display matrix

imagesc(pairwise_distance_matrix);
colorbar;

%% Compute amount of mistakes


amount_of_images_per_face = 10;
amount_of_faces = 50;

amount_of_all_images = amount_of_faces*amount_of_images_per_face;

amount_of_mistakes = 0;
amount_of_possible_mistakes = 0;

for face = 1:amount_of_faces
    
    images_to_be_verified_begin_index = (face-1)*amount_of_images_per_face + 1;
    images_to_be_verified_end_index = images_to_be_verified_begin_index + amount_of_images_per_face - 1;
    
    for current_verified_image = images_to_be_verified_begin_index:images_to_be_verified_end_index
    
        for verified_image_from_the_same_class = current_verified_image:images_to_be_verified_end_index

            for current_image_from_another_class = 1:amount_of_all_images

                if current_image_from_another_class < images_to_be_verified_begin_index || current_image_from_another_class > images_to_be_verified_end_index
                    
                    amount_of_possible_mistakes = amount_of_possible_mistakes + 1;
                    
                    if pairwise_distance_matrix( current_verified_image, current_image_from_another_class ) <= pairwise_distance_matrix( current_verified_image, verified_image_from_the_same_class )
                        amount_of_mistakes = amount_of_mistakes + 1;
%                         current_verified_image
%                         current_image_from_another_class
%                         verified_image_from_the_same_class
                    end
                end
            end
        end
    end
        
end