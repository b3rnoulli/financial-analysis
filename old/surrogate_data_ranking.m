function [ transformed_series ] = surrogate_data_ranking( original_series )

transformed_series = zeros(1,length(original_series));
random_series = normrnd(0,1,[1 length(original_series)]);
sorted_random = sort(random_series);
sorted_original = sort(original_series);

% sprawdzic
for i=1:length(sorted_original)
    index = lrr == sorted_original(i);
    transformed_series(index)= sorted_random(i);
end

end

