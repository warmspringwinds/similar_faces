% Offset parametr. Percentage of area to upper bourder and to 
% side boarders from each eye. Look align_and_crop function for more
offset_nearby_eyes = [ 0.2, 0.22];

% Size of ouput images with faces
desired_size = [60, 80];

image = imread('similar_faces_db/Lookalike_Final_Publish_v6.0/2_All/32_imp_3.jpg');

load('similar_faces_db/Lookalike_Final_Publish_v6.0/2_All/32_imp_3.mat');

% Get eyes coords 21 - left eye 67 - right eye
left_eye_coords = landmarks_coords(21, :);
right_eye_coords = landmarks_coords(67, :);

result = image_manipulation.align_and_crop_face(image, left_eye_coords, right_eye_coords, offset_nearby_eyes, desired_size);

imshow(result);