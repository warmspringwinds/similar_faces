
clc; clear;

addpath('facepp/');

% input your API_KEY & API_SECRET
API_KEY = 'd45344602f6ffd77baeab05b99fb7730';
API_SECRET = 'jKb9XJ_GQ5cKs0QOk6Cj1HordHFBWrgL';

% If you have chosen Amazon as your API sever and 
% changed API_KEY&API_SECRET into yours, 
% pls reform the FACEPP call as following :
% api = facepp(API_KEY, API_SECRET, 'US')
api = facepp(API_KEY, API_SECRET);

image_path = 'similar_faces_db/Lookalike_Final_Publish_v6.0/2_All/';

img_list = dir([image_path, '*.jpg']);

for i = 1:size(img_list, 1)
    
    % Images number 378 and 392 will fail to detect
   
    img_name = img_list(i).name;
    
    im = imread([ image_path, img_name ]);
    
    rst = detect_file(api, [ image_path, img_name ], 'all');
    img_width = rst{1}.img_width;
    img_height = rst{1}.img_height;
    face_i = rst{1}.face{1};
    
    center = face_i.position.center;
    w = face_i.position.width / 100 * img_width;
    h = face_i.position.height / 100 * img_height;

    
   % Detect facial key points
    rst2 = api.landmark(face_i.face_id, '83p');
    landmark_points = rst2{1}.result{1}.landmark;
    landmark_names = fieldnames(landmark_points);
    
    landmarks_coords_to_save = zeros(83, 2);
    
    % Draw facial key points
    for j = 1 : length(landmark_names)
        pt = getfield(landmark_points, landmark_names{j});
        landmarks_coords_to_save(j, :) = [ pt.x * img_width / 100, pt.y * img_height / 100 ];
    end
    
    [ans, plain_name, extention] = fileparts([ image_path, img_name ]);
    
    filename_to_save = [image_path, plain_name '.mat'];
    
    save(filename_to_save, 'landmarks_coords_to_save');
    
    
end