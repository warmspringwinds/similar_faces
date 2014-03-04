
% Offset parametr. Percentage of area to upper bourder and to 
% side boarders from each eye. Look align_and_crop function for more
offset_nearby_eyes = [ 0.2, 0.22];

% Size of ouput images with faces
desired_size = [200, 220];

image = imread('original_images_with_faces_and_landmarks/17.png');

% Load landmark coordinated of image.
face_coords = load('original_images_with_faces_and_landmarks/17.txt');

% Get eyes coords 26 - left eye 27 - right eye
left_eye_coords = face_coords(26, :);
right_eye_coords = face_coords(27, :);

result = align_and_crop_face(image, left_eye_coords, right_eye_coords, offset_nearby_eyes, desired_size);

imshow(result);