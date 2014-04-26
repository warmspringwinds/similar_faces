% Offset parametr. Percentage of area to upper bourder and to 
% side boarders from each eye. Look align_and_crop function for more
offset_nearby_eyes = [ 0.2, 0.22];

% Size of ouput images with faces
% Previously it was 200 220
desired_size = [60, 80];

% Specify folder name where to put aligned and cropped images
folder_name_to_save_cropped_images = 'similar_faces_db/Lookalike_Final_Publish_v6.0/aligned_cropped_gray/';

% Create folder if it doesn't exist
if ~exist(folder_name_to_save_cropped_images, 'dir')
    mkdir(folder_name_to_save_cropped_images);
end

image_path = 'similar_faces_db/Lookalike_Final_Publish_v6.0/2_All/';

img_list = dir([image_path, '*.jpg']);

for i = 1:size(img_list, 1)
    
    img_name = img_list(i).name;
    
    image = imread([ image_path, img_name ]);
    
    [ans, plain_name, extention] = fileparts([ image_path, img_name ]);
    
    landmarks_file_name = [image_path, plain_name, '.mat'];
    
    image_name_to_save = [ folder_name_to_save_cropped_images, plain_name, '.bmp']
    
    % The name of variable that is loaded is 'landmarks_coords_to_save'
    load( landmarks_file_name );
    
    % Get eyes coords 21 - left eye 67 - right eye
    left_eye_coords = landmarks_coords(21, :);
    right_eye_coords = landmarks_coords(67, :);

    result = image_manipulation.align_and_crop_face(image, left_eye_coords, right_eye_coords, offset_nearby_eyes, desired_size);
    
    result = rgb2gray(result);
    
    imwrite(result, image_name_to_save, 'bmp');
    
end