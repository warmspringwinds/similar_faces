% Script to align and crop all faces from a given directory with images
% and file with landmark points associated with each image.

image_name_spec = 'original_images_with_faces_and_landmarks/%s.png';
image_landmark_spec = 'original_images_with_faces_and_landmarks/%s.txt';
image_save_spec = 'aligned_cropped_faces_gray/%s.bmp';

% Offset parametr. Percentage of area to upper bourder and to 
% side boarders from each eye. Look align_and_crop function for more
offset_nearby_eyes = [ 0.2, 0.22];

% Size of ouput images with faces
desired_size = [200, 220];

for i = 1:20
    str_number = int2str(i);
   
    image_file_name = sprintf(image_name_spec, str_number);
    landmark_file_name = sprintf(image_landmark_spec, str_number);
    
    image = imread(image_file_name);
    
    % Load landmark coordinated of each image.
    face_coords = load(landmark_file_name);
    
    % Get eyes coords 26 - left eye 27 - right eye
    left_eye_coords = face_coords(26, :);
    right_eye_coords = face_coords(27, :);
     
    result = align_and_crop_face(image, left_eye_coords, right_eye_coords, offset_nearby_eyes, desired_size);
    
    img_name_to_save = sprintf(image_save_spec, str_number);
    
    result = rgb2gray(result) ;
    
    imwrite(result, img_name_to_save, 'bmp');
    
end


