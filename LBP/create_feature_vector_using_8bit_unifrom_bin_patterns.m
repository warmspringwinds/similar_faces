function [ feature_vector ] = create_feature_vector_using_8bit_unifrom_bin_patterns( img, circular_radius, amount_of_blocks_for_histogram_on_each_axis)
    % Computes feature vector using 8bit rotation invariant uniform binary
    % patterns
    % Input:
    % @img - gray-scale img to create feature vector for
    % @circular_radius - circular radius used when creating local binary
    % patterns. Best for face recognition is 2. The bigger the radius the
    % bigger details can be captured but small details will be lost.
    % The smaller the radius the smaller details can be captured
    % @amount_of_blocks_for_histogram_on_each_axis - the feature vector
    % will be amount_of_blocks_for_histogram_on_each_axis^2 size. The
    % bigger this number the more precise the result will be, but feature
    % vector will be bigger.
    % Output:
    % @feature_vector - resulted feature vector of size
    % amount_of_blocks_for_histogram_on_each_axis^2
    
    circular_points_amount = 8;
    
    % Load precomputer look-up table of rotation invariant uniform binary patterns
    load('8bit_uniform_binary_patterns_look_up_table.mat');

    % Variable where the table is stored
    eight_bit_binary_patterns_table;
    
    % Simple LBP without rotation invariance
    plain_circular_binary_patterns = img2circular_binary_patterns(img, circular_radius, circular_points_amount);

    % Create uniform rotation invariant binary patterns with
    % the help of precomputed look-up table.
    converted_img = intlut(plain_circular_binary_patterns, eight_bit_binary_patterns_table);
    
    [row_indexes, column_indexes] = split_matrix_into_equal_regions(size(converted_img), amount_of_blocks_for_histogram_on_each_axis);
    
    % Ten values - because patterns are uniform
    histogram_range = 1:10;

    % Creat histograms. Each row - histogram for region
    features = compute_histograms_of_specified_rectangle_areas(converted_img, row_indexes, column_indexes, histogram_range);
    
    % Concatenate rows into one feature vector
    feature_vector = reshape(features.', [], 1);

end

