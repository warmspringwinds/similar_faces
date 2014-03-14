function [ distance ] = chi_squared_distance( first_vector, second_vector )
    % This measure of distance is primary oriented on positive vectors
    % For example to measure distance between histograms
    % d(x,y) = sum( (xi-yi)^2 / (xi+yi) )
    
    distance = ( (first_vector - second_vector).^2 ) ./ (first_vector + second_vector);
    
    % This code is targeted to elimiate the NaN that can be obtained after
    % dividing by 0
    distance(isnan(distance)) = 0;
    distance = sum(distance);

end

