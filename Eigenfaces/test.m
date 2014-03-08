% Script to create feature vectors out of gray-scale cropped and aligned
% faces and save it to a .mat file for future use.

image_name_spec = '../aligned_cropped_faces_gray/%s.bmp';

face_size = size( imread('../aligned_cropped_faces_gray/1.bmp') );

mean_face = zeros(face_size(1), face_size(2), 'double');

training_faces = zeros( face_size(1) * face_size(2), 20, 'double');

for i = 1:20

    str_number = int2str(i);
   
    image_file_name = sprintf(image_name_spec, str_number);
    
    image = double( imread(image_file_name) );
    
    mean_face = mean_face + image;
    
    training_faces(:, i) = double( reshape(image, [], 1) );
    
end

mean_face = mean_face / 20;

mean_face = reshape(mean_face, [], 1);

for i = 1:20
    training_faces(:, i) = training_faces(:, i) - mean_face;
end


L = training_faces' * training_faces;

[V D] = eig(L);
[D, i] = sort(diag(D), 'descend');
V = V(:,i);
E = training_faces * V;
