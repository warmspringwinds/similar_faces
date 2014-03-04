function [ output_img ] = align_and_crop_face( image, left_eye_coords, right_eye_coords, offset_near_eyes, output_size  )
    % Function that is used to align and crop face by coordinates of eyes
    % on the image.
    % Input:
    % @image - input image
    % @left_eye_coords, @right_eye_coords - left and right coords of eyes
    % [x, y]
    % on the image
    % @offset_near_eyes - the percent of the image you want to keep next to the eyes (horizontal, vertical direction)
    % @output_size - output image size [height, width]
    % Output:
    % @output_img - aligned and cropped face
    
    
    % Vector showing the line connectig eyes
    eye_direction = right_eye_coords - left_eye_coords;
    
    % Direction of the vector shows the angle. Take the opposite angle
    angle_to_align_eyes = -atan2(eye_direction(2), eye_direction(1));

    [ xdata, ydata, transform_handler, rotated_img ] = rotate_img( image, left_eye_coords, angle_to_align_eyes);
    
    % Transform eyes coords to new coordinate system.
    left_eye_coords = tformfwd(left_eye_coords, transform_handler);
    right_eye_coords = tformfwd(right_eye_coords, transform_handler);
    
    % Get the coordinates of new output rectangle matrix. Image will be expanded to rectangle.
    % For example, rotated matrix will be expanded
    left_eye_coords = left_eye_coords - [ xdata(1), ydata(1) ] + [1, 1];
    right_eye_coords = right_eye_coords - [ xdata(1), ydata(1) ] + [1, 1];
    
    % Determine the desired distance from eyes to upper and side borders
    offset_horizontal = floor( offset_near_eyes(1)*output_size(1) );
    offset_vertical = floor( offset_near_eyes(2)*output_size(2) );
    desired_eyes_distance = output_size(1) - 2*offset_horizontal;
    
    % Determine this distance in a given image. This is the length of
    % vector or its norm.
    eyes_distance = norm( right_eye_coords - left_eye_coords );
    
    % Get the ratio of those distances.
    scale = eyes_distance / desired_eyes_distance;
    
    % Determine the top left coords of rectangle to be cropped using the ratio.
    facebox_top_left_coords = left_eye_coords - [ offset_horizontal, offset_vertical ] * scale;
    
    % Get the size of rectangle to be cropped
    facebox_width = output_size(1)*scale;
    facebox_height = output_size(2)*scale;

    cropped_image = imcrop(rotated_img, [facebox_top_left_coords(1),  facebox_top_left_coords(2), facebox_width, facebox_height ]);
    
    resized_image = imresize(cropped_image, [output_size(2) output_size(1)], 'Antialiasing', true);
    
    output_img = resized_image;

end

