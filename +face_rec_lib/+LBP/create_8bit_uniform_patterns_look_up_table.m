function [ eight_bit_binary_patterns_table ] = create_8bit_uniform_patterns_look_up_table()
    % By this moment this function is implemented only for 8 bit binary
    % uniform circular patterns

    % Look up table decimal number -> number of pattern.

    % Creating look-up table with uniform patterns for 8 points
    % There are 9 uniform patterns with at most 2 0/1 or 1/0 transitions.
    % Example of uniform pattern 00000000, 10000000 ...
    % To find all the possible circular binary shifts of uniform patterns
    % we will start with the minimum possible value of each uniform pattern
    % where it has the bigest amount of 0 on the left.
    % Other patterns will be assigned to 10. It will be the rest numbers.
    % This is why all start values in array are 10.

    % Fill out with default values - non-uniform patterns
    uniform_patterns_look_up_table = ones(256, 1, 'uint8') * 10;

    minimun_uniform_binary_patterns =  [ ... 
                                        [0 0 0 0 0 0 0 0]', ...
                                        [1 0 0 0 0 0 0 0]', ...
                                        [1 1 0 0 0 0 0 0]', ...
                                        [1 1 1 0 0 0 0 0]', ...
                                        [1 1 1 1 0 0 0 0]', ...
                                        [1 1 1 1 1 0 0 0]', ...
                                        [1 1 1 1 1 1 0 0]', ...
                                        [1 1 1 1 1 1 1 0]', ...
                                        [1 1 1 1 1 1 1 1]', ...
                                       ];

    % 7 - amount of shift enough to get all possible circular shift.
    for size_of_shift = 0:7
        shifted_uniform_patterns = circshift(minimun_uniform_binary_patterns, size_of_shift);

        for number_of_uniform_pattern = 1:9
            resulted_decimal_number = 0;
            for number_of_bit = 1:8
                % Translate binary pattern to decimal number.
                resulted_decimal_number = resulted_decimal_number + 2^(number_of_bit-1)*shifted_uniform_patterns(number_of_bit, number_of_uniform_pattern);
            end

            uniform_patterns_look_up_table(resulted_decimal_number+1) = number_of_uniform_pattern;
        end
    end


    eight_bit_binary_patterns_table = uniform_patterns_look_up_table;

end

