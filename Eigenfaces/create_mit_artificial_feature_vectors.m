% Script to create feature vectors out of provided face images

start_up_script;

%% Set up parameters

amount_of_biggest_eigen_vectors_to_use = 9;

number_of_people = 10;

% Naming convention changes after 5th face image
% First substituted value - number of person, second - illumination
% parameter
image_name_spec_1 = '../mit_faces/training-synthetic/000%s_0_0_0_15_%s_1.pgm';
image_name_spec_2 = '../mit_faces/training-synthetic/000%s_0_0_0_0_15_%s_1.pgm';

sample_face_image = imread( sprintf(image_name_spec_1, '1', '0' ) );

face_size = size( sample_face_image );

training_faces = zeros( face_size(1) * face_size(2), number_of_people, 'double');

%% Load training faces images

for i = 0:number_of_people-1

    str_number = int2str(i);
    
    if i < 6
        image_name_spec = image_name_spec_1;
    else
        image_name_spec = image_name_spec_2;
    end
   
    image_file_name = sprintf(image_name_spec, str_number, '0');
    
    face_image = double( imread(image_file_name) );
    
    training_faces(:, i+1) = reshape(face_image, [], 1);
    
end

[ mean_face, faces_difference_vectors, eigen_faces_vectors_descend, eigen_values_descend ] = face_rec_lib.Eigenfaces.create_eigenface_system(training_faces);

%% Compute the ratio of data that we will save

% In this case with the amount of 9 eigenvectors about 86 amount of data is
% saved

data_preserve_ratio = sum(eigen_values_descend(1:amount_of_biggest_eigen_vectors_to_use)) / sum(eigen_values_descend);

%% Load test images

test_faces = zeros( face_size(1) * face_size(2), number_of_people*6, 'double');

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

        test_faces(:, i*6 + (illumination+1) ) = reshape(face_image, [], 1) - mean_face;
    end
    
end


%% Represent faces as a combination of specified number of biggest eigenfaces

eigen_vectors_to_use = eigen_faces_vectors_descend(:, 1:amount_of_biggest_eigen_vectors_to_use);

% Create projecting matrix that consists of eigevectors that are placed in
% rows of this matrix
projecting_matrix = eigen_vectors_to_use';

% We are using normalized face vectors because to get to new coordinate system you also
% need to do translation i.e change system to new origin that is located in
% mean value of data

% Get projection. In this case they will be used as feature vectors.
eigenfaces_feature_vectors = projecting_matrix * test_faces;

% This is done to follow common style for saving feature vectors
% Each row is a feature vector for corresponding face 
eigenfaces_mit_artificial_feature_vectors = eigenfaces_feature_vectors';

save('../feature_vectors/mit_artificial_faces/Eigenfaces_feature_vectors.mat', 'eigenfaces_mit_artificial_feature_vectors');


