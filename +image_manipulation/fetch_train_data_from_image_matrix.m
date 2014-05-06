function [ training_data, new_lables ] = fetch_train_data_from_image_matrix( image_matrix, lables )
    %FETCH_TRAIN_DATA_FROM_IMAGE_MATRIX Summary of this function goes here
    %   Detailed explanation goes here
    
    training_data = [];
    
    classes = unique( lables );
    
    % Remove class with lable -1. This lable is used to mark elements that
    % are not supposed to be used in training data.
    if classes(1) == -1
        classes = classes(2:end);
    end
    
    classes_amount = length( classes );
    
    for current_class = 1:classes_amount
        
        current_class_data = image_matrix( find(lables == classes(current_class)), : );
        
        training_data = [ training_data; current_class_data ];
        
    end
        
    % Create new lables array with -1 elements removed
    new_lables = lables( find( ~(lables == -1) ) ); 
        
end

