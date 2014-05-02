% Script that demonstrates work of PCA principle component analysis

start_up_script;

%% Load data
test_data_2 = [2 3;3 4;4 5;5 6;5 7;2 1;3 2;4 2;4 3;6 4;7 6];

test_data = [9 39; 15 56; 25 93; 14 61; 10 50; 18 75; 0 32; 16 85; 5 42; 19 70; 16 66; 20 80];

%% Plot test data
plot(test_data_2(:,1), test_data_2(:, 2), 'o');

[eigen_vectors, mean_array] = face_rec_lib.Fisherfaces.principal_component_analysis( test_data_2, 2);

scale = 10;

% Plot first eigen vector
line([mean_array(1) - scale*eigen_vectors(1, 1), mean_array(1) + scale*eigen_vectors(1, 1)], ...
     [mean_array(2) - scale*eigen_vectors(2, 1), mean_array(2) + scale*eigen_vectors(2, 1)], 'Color', 'r');
 
% Plot second one
line([mean_array(1) - scale*eigen_vectors(1, 2), mean_array(1) + scale*eigen_vectors(1, 2)], ...
     [mean_array(2) - scale*eigen_vectors(2, 2), mean_array(2) + scale*eigen_vectors(2, 2)], 'Color', 'b');



