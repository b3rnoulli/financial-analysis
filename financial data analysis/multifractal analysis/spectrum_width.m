function [ width ] = spectrum_width(alfa , f)
fprintf('[spectrum_width]: Calculating spectrum width coeffcient \n');

tmp = abs(f-1);
[~, closest_to_one_index] = min(tmp); 
[~, right_min] = min(f(1:closest_to_one_index));
[~, left_min] = min(f(closest_to_one_index:end));
left_min = left_min+closest_to_one_index-1;
width = abs(alfa(right_min) - alfa(left_min));
fprintf('[spectrum_width]: Calculated spectrum width coeffcient %s\n',num2str(width));
end

