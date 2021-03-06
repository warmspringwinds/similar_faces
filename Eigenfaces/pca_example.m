% Script that demonstrates work of PCA principle component analysis

%% Load data
test_data_2 = [2 3;3 4;4 5;5 6;5 7;2 1;3 2;4 2;4 3;6 4;7 6];

test_data = [9 39; 15 56; 25 93; 14 61; 10 50; 18 75; 0 32; 16 85; 5 42; 19 70; 16 66; 20 80];

%% Plot test data
plot(test_data(:,1), test_data(:, 2), 'o');

%% Compute covariance matrix
% With the help of matlab you can compute the same with cov(test_data_2, 1)
% 1 is to make matlab divide the matrix by n and not by n-1

% Mean or expected value for each variable(in this case for each column)
mean_array = mean(test_data);

% Subtract from each variable its expected value. So that now expected
% values for each variable is 0.
normalized = bsxfun(@minus, test_data, mean_array);

% Compute variance matrix
covariance_matrix = (normalized' * normalized) ./ size(test_data, 1);

%% Find eigenvectors and eigenvalues of covariance matrix

[eigen_vectors, eigen_values] = eig(covariance_matrix);

% Sort eigenvalues in descending order, so that it will be easier to omit
% vectors with small eigen values
[eigen_values_descend, eigen_values_descend_index] = sort(diag( eigen_values ), 'descend');

% Sort eigenvectors in the same way
eigen_vectors = eigen_vectors(:, eigen_values_descend_index);

%% Dislplay eigen vectors and data

scale = 10;

% Plot first eigen vector
line([mean_array(1) - scale*eigen_vectors(1, 1), mean_array(1) + scale*eigen_vectors(1, 1)], ...
     [mean_array(2) - scale*eigen_vectors(2, 1), mean_array(2) + scale*eigen_vectors(2, 1)], 'Color', 'r');
 
% Plot second one
line([mean_array(1) - scale*eigen_vectors(1, 2), mean_array(1) + scale*eigen_vectors(1, 2)], ...
     [mean_array(2) - scale*eigen_vectors(2, 2), mean_array(2) + scale*eigen_vectors(2, 2)], 'Color', 'b');

%% Get coordinates of points in the new system

% Create projecting matrix that consists of eigevectors that are placed in
% rows of this matrix
projecting_matrix = eigen_vectors';

% We are using normalized because to get to new coordinate system you also
% need to do translation i.e change system to new origin that is located in
% mean value of data
projected_data = projecting_matrix * normalized';

%% Show projection of point on one eigen vector

projections_on_first_eigen_vector = projected_data(1, :);

% Translate these coordinates in usual coordinates, so that to be able to
% show them properly
% New origin coordinates + eigen vector * coordinates in that system or
% projection on this eigenvector
data_to_display = bsxfun(@plus, mean_array', eigen_vectors(:, 1) * projections_on_first_eigen_vector);

hold on
plot(data_to_display(1, :), data_to_display(2, :), '*');