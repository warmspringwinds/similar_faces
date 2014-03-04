image = imread('original_images_with_faces_and_landmarks/6.png');

% Load landmark coordinated of image.
face_coords = load('original_images_with_faces_and_landmarks/6.txt');

% Get eyes coords 26 - left eye 27 - right eye
left_eye_coords = face_coords(26, :);
right_eye_coords = face_coords(27, :);

% Vector showing the line connectig eyes
eye_direction = right_eye_coords - left_eye_coords;

% Direction of the vector shows the angle. Take the opposite angle
angle_to_align_eyes = -atan2(eye_direction(2), eye_direction(1));

[ xdata, ydata, transform_handler, rotated_img ] = rotate_img( image, left_eye_coords, angle_to_align_eyes);

imshow(rotated_img);