% Script to create feature vectors out of provided face images

start_up_script;

%% Set up parameters and create and save feature vectors

amount_of_biggest_eigen_vectors_to_use = 9;

number_of_people = 10;

number_of_images = number_of_people*6;

% Naming convention changes after 5th face image
% First substituted value - number of person, second - illumination
% parameter
image_name_spec_1 = '../mit_faces/training-synthetic/000%s_0_0_0_15_%s_1.pgm';
image_name_spec_2 = '../mit_faces/training-synthetic/000%s_0_0_0_0_15_%s_1.pgm';

sample_face_image = imread( sprintf(image_name_spec_1, '1', '0' ) );

face_size = size( sample_face_image );

lables = zeros(1, number_of_images );

training_faces = zeros( number_of_images, face_size(1) * face_size(2), 'double');

for i = 0:number_of_people-1
    
    str_number = int2str(i);
    
    if i < 6
        image_name_spec = image_name_spec_1;
    else
        image_name_spec = image_name_spec_2;
    end
    
    % 6 types of different illumination. Can be used more
    for illumination = 0:5
        
        image_file_name = sprintf(image_name_spec, str_number, int2str( illumination * 15 ));
    
        face_image = double( imread(image_file_name) );

        training_faces( i*6 + (illumination+1), : ) = reshape(face_image, 1, []);
        
        lables( i*6 + (illumination+1) ) = i;
    end
    
end

[ project_matrix, mean ] = face_rec_lib.Fisherfaces.create_fisherface_system(training_faces, lables, amount_of_biggest_eigen_vectors_to_use);

fisherfaces_mit_artificial_feature_vectors = face_rec_lib.Fisherfaces.project(project_matrix, training_faces, mean);

save('../feature_vectors/mit_artificial_faces/Fisherfaces_feature_vectors.mat', 'fisherfaces_mit_artificial_feature_vectors');

%% Example of reconstruction of faces

number_of_reconstructed_face_to_show = 15;

reconstructed_faces = face_rec_lib.Fisherfaces.reconstruct(project_matrix, fisherfaces_mit_artificial_feature_vectors, mean);

reconstructed_face_to_show = reconstructed_faces(number_of_reconstructed_face_to_show, :);

reconstructed_face_to_show = face_rec_lib.Eigenfaces.normalize_vector(reconstructed_face_to_show, 0, 255);

reconstructed_face_to_show = uint8( reshape( reconstructed_face_to_show, face_size(1), [] ) );

imshow( reconstructed_face_to_show );

% colormap ( jet (256) );
% colorbar;

