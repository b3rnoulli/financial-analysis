function [ transformed_series ] = surrogate_rankings( original_series )
fprintf('[surrogate_rankings] Calulating surrogate with preserved organization and changed distribution \n');

transformed_series = zeros(1,length(original_series));
random_series = normrnd(0,1,[1 length(original_series)]);
sorted_random = sort(random_series);
sorted_original = sort(original_series);

for i=1:length(sorted_original)
    index = original_series == sorted_original(i);
    transformed_series(index)= sorted_random(i);
end

fprintf('[surrogate_rankings] Calculated surrogate with preserved organization and changed distribution \n');
end

