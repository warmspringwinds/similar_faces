function [ distance ] = chi_squared_distance( first_vector, second_vector )
    % d(x,y) = sum( (xi-yi)^2 / (xi+yi) )
    
    distance = ( (first_vector - second_vector).^2 ) ./ (first_vector + second_vector);
    distance(isnan(distance)) = 0;
    distance = sum(distance);

end

