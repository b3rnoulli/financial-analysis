function [ a_alpha ] = spectrum_asymmetry( alfa_middle, alfa_left, alfa_right )
fprintf('[spectrum_asymmetry]: Calculating spectrum asymmetry coeffcient \n');

left_width = alfa_middle-min(alfa_left);
right_width = max(alfa_right) - alfa_middle;
a_alpha = (left_width - right_width)/(right_width + left_width);

fprintf('[spectrum_asymmetry]: Calculated spectrum asymmetry coeffcient %.3d \n', a_alpha);
end

