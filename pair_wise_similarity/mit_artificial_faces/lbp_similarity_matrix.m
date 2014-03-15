% Script that creates matrix of similarity between each feature vector
% representing corresponding face. In this example chi squared distance is
% used.

%% Compute pair-wise matrix

start_up_script;

load('../../feature_vectors/mit_artificial_faces/LBP_feature_vectors.mat');

lbp_feature_vectors = double(lbp_mit_artificial_feature_vectors);

amount_of_vectors = size(lbp_feature_vectors, 1);

pairwise_distance_matrix = zeros(amount_of_vectors);

for i = 1:amount_of_vectors
    for j = 1:amount_of_vectors
         pairwise_distance_matrix(i, j) = face_rec_lib.LBP.chi_squared_distance(lbp_feature_vectors(i, :), lbp_feature_vectors(j, :));
%        pairwise_distance_matrix(i, j) = norm( lbp_feature_vectors(i, :) - lbp_feature_vectors(j, :) );
    end
end

%% Display matrix

imagesc(pairwise_distance_matrix);
colorbar;

%% Compute amount of mistakes

amount_of_images_per_face = 6;
amount_of_faces = 10;

amount_of_all_images = amount_of_faces*amount_of_images_per_face;

amount_of_mistakes = 0;

for face = 1:amount_of_faces
    
    original_image_to_compare_with_index = (face-1)*amount_of_images_per_face + 1;
    images_to_be_verified_end_index = original_image_to_compare_with_index + amount_of_images_per_face - 1;
    
    for face_image = 0:amount_of_images_per_face-1
        
        
        for current_element = 1:amount_of_all_images
            
            if current_element < original_image_to_compare_with_index || current_element > images_to_be_verified_end_index
                if pairwise_distance_matrix( original_image_to_compare_with_index, current_element ) <= pairwise_distance_matrix( original_image_to_compare_with_index, original_image_to_compare_with_index + face_image )
                    amount_of_mistakes = amount_of_mistakes + 1;
                    original_image_to_compare_with_index
                    original_image_to_compare_with_index + face_image
                    current_element
                end
            end
        end
        
    end
    
end




