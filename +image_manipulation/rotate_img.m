function [ xdata, ydata, transformation_handler, rotated_img ] = rotate_img( img, center_of_rotation, angle)
    % Function used to rotate image around specified center using affine translation + rotation.
    % Input:
    % @img - image to rotate
    % @center_of_rotation - center around which you want to rotate your
    % image
    % @angle - angle of rotation in radians!
    % Output:
    % @xdata, @ydata -A two-element, real vector that, when combined with 'YData'
    % specifies the spatial location of the output image B in the 2-D output space X-Y. 
    % The two elements of 'XData' give the x-coordinates (horizontal) of the first and last columns of B, respectively.
    % To transform coordinates of original image before rotation to the
    % pixels of output matrix rotated_img you should do tformfwd(original_coords, transformation_handler)
    % and then x - xdata(1) and y - ydata(1). Read more on imtransform()
    % matlab function.
    % @transformation_handler - handler returned by maketform()
    % @rotated_img - img after rotation. Dark areas can be added to make
    % the output img rectangle. To cope with it use xdata and ydata.
    
    
    % Change the origin to the center of rotation
    translation_matrix = [ 1 0 0; 0 1 0; -center_of_rotation(1) -center_of_rotation(2) 1 ];
    
    % Rotation matrix with homogenous coordinates
    rotation_matrix = [ cos(angle) sin(angle) 0; -sin(angle) cos(angle)  0; 0 0 1 ];

    combined_matrix = translation_matrix * rotation_matrix;

    T = combined_matrix;

    transformation_handler = maketform('affine', combined_matrix);
    
    [rotated_img xdata ydata] = imtransform(img,transformation_handler);

end

