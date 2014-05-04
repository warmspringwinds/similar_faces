function [  images_matrix, image_size, amount_of_images ] = load_images_in_matrix_rows( images_path, images_regex )
    %LOAD_IMAGES_IN_MATRIX Summary of this function goes here
    %   Detailed explanation goes here
    
    convert_rgb_to_grayscale = false;
    
    img_list = dir([images_path, images_regex]);

    amount_of_images = size(img_list, 1);

    sample_image_name = img_list(1).name;

    sample_image = imread([ images_path, sample_image_name ]);
    
    if size(sample_image, 3) == 3
        convert_rgb_to_grayscale = true;
        sample_image = rgb2gray(sample_image);
    end
    
    image_size = size( sample_image );

    images_matrix = zeros( amount_of_images, image_size(1) * image_size(2), 'double');

    for i = 1:amount_of_images

        img_name = img_list(i).name;
        
        image = imread([ images_path, img_name ]);
        
        if convert_rgb_to_grayscale
            image = rgb2gray( image );
        end
            
        image = double( image );

        images_matrix(i, :) = reshape(image, 1, []);

    end

end

