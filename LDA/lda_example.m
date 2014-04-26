% Script that demonstrates work of LDA linear disctiminant analysis

%% Load data

% First example
% X_1 = [4, 2; 2, 4; 2, 3; 3, 6; 4, 4];
% X_2 = [9, 10; 6, 8; 9, 5; 8, 7; 10, 8];

% Second example
X_1 = [2 3; 3 4; 4 5; 5 6; 5 7];
    
X_2 = [2 1; 3 2; 4 2; 4 3; 6 4; 7 6];

all_data = [X_1; X_2];

%% Do the calculations

mean_1 = mean(X_1)';
mean_2 = mean(X_2)';
mean_overall = mean(all_data)';

scatter_1 = cov(X_1);
scatter_2 = cov(X_2);

within_class_scatter = scatter_1 + scatter_2;
between_class_scatter = (mean_1 - mean_2) * (mean_1 - mean_2)';

inv_within_class_scatter = inv(within_class_scatter);

matrix_to_find_eigen_values = inv_within_class_scatter * between_class_scatter;

[V, D] = eig(matrix_to_find_eigen_values);

% Get the eigenvector with the largest eigenvalue

W = V(:, 2);

%% Plot test data

hold on;
plot(X_1(:,1), X_1(:, 2), 'ro');
plot(X_2(:,1), X_2(:, 2), 'go');

%% Dislplay eigen vectors and data

scale = 10;

% Plot first eigen vector
line([mean_overall(1) - scale*W(1), mean_overall(1) + scale*W(1)], ...
     [mean_overall(2) - scale*W(2), mean_overall(2) + scale*W(2)], 'Color', 'r');

% line([ -scale*W(1), scale*W(1)], ...
%      [ -scale*W(2), scale*W(2)], 'Color', 'r');




