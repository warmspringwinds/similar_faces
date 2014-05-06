function [ pairwise_distance_matrix ] = create_pairwise_distance_matrix( data_matrix, distance_measure )
    %CREATE_ Summary of this function goes here
    %   Detailed explanation goes here
    
   amount_of_vectors = size(data_matrix, 1);

   pairwise_distance_matrix = zeros(amount_of_vectors); 
    
   switch distance_measure
       
       case 'euclidean'
           
           for i = 1:amount_of_vectors
                for j = 1:amount_of_vectors
                    pairwise_distance_matrix(i, j) = norm( data_matrix(i, :) - data_matrix(j, :) );
                end
           end
           
   end
    
end

