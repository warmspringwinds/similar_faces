function [ amount_of_mistakes, amount_of_possible_mistakes ] = compute_amount_of_mistakes_in_distance_matrix( pairwise_distance_matrix, amount_of_classes, amount_of_samples_per_class )
    %COMPUTE_AMOUNT_OF_MISTAKES_IN_DISTANCE_MATRIX Summary of this function goes here
    %   Detailed explanation goes here
    
    amount_of_all_samples = amount_of_classes*amount_of_samples_per_class;

    amount_of_mistakes = 0;
    amount_of_possible_mistakes = 0;

    for face = 1:amount_of_classes

        images_to_be_verified_begin_index = (face-1)*amount_of_samples_per_class + 1;
        images_to_be_verified_end_index = images_to_be_verified_begin_index + amount_of_samples_per_class - 1;

        for current_verified_image = images_to_be_verified_begin_index:images_to_be_verified_end_index

            for verified_image_from_the_same_class = current_verified_image:images_to_be_verified_end_index

                for current_image_from_another_class = 1:amount_of_all_samples

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
    
end

