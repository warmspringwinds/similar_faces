% Script that creates 8bit uniform pattern look up table that can be used
% later it can be used to upgrade image translated to circular or square
% binary patterns to uniform binary patterns

start_up_script;

eight_bit_binary_patterns_table = face_rec_lib.LBP.create_8bit_uniform_patterns_look_up_table();

save('8bit_uniform_binary_patterns_look_up_table.mat','eight_bit_binary_patterns_table');





                               