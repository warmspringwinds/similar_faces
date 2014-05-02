% Script that demonstrates work of LDA linear disctiminant analysis

%% Load new path into load path

start_up_script;

%% First example
samples = [4, 2; 2, 4; 2, 3; 3, 6; 4, 4; 9, 10; 6, 8; 9, 5; 8, 7; 10, 8];

lables = [  1  1  1  1  1  2  2  2  2  2];

[V, overall_mean] = face_rec_lib.Fisherfaces.linear_discriminant_analysis( samples, lables, 1);

c1 = samples(find(lables == 1), :);
c2 = samples(find(lables == 2), :);

figure;

p1 = plot(c1(:,1), c1(:,2), 'ro', 'markersize', 10, 'linewidth', 3); 

hold on;

p2 = plot(c2(:,1), c2(:,2), 'go', 'markersize', 10, 'linewidth', 3);

xlim([0 15]);
ylim([0 15]);


scale = 20;
pc1 = line([overall_mean(1) - scale * V(1,1) overall_mean(1) + scale * V(1,1)], [overall_mean(2) - scale * V(2,1) overall_mean(2) + scale * V(2,1)]);

%% Second example

samples = [ 2 3; 3 4; 4 5; 5 6; 5 7; 2 1; 3 2; 4 2; 4 3; 6 4; 7 6];
lables = [  1  1  1  1  1  2  2  2  2  2  2];

[V, overall_mean] = face_rec_lib.Fisherfaces.linear_discriminant_analysis( samples, lables, 1);

c1 = samples(find(lables == 1), :);
c2 = samples(find(lables == 2), :);

figure;

p1 = plot(c1(:,1), c1(:,2), 'ro', 'markersize', 10, 'linewidth', 3); hold on;
p2 = plot(c2(:,1), c2(:,2), 'go', 'markersize', 10, 'linewidth', 3);

xlim([0 8]);
ylim([0 8]);


scale = 5;
pc1 = line([overall_mean(1) - scale * V(1,1) overall_mean(1) + scale * V(1,1)], [overall_mean(2) - scale * V(2,1) overall_mean(2) + scale * V(2,1)]);






