function [ transformed_series ] = surrogate_standard( original_series )
fprintf('[surrogate_standard] Calulating standard surrogate \n');
transformed_series=original_series(randperm(length(original_series)));
fprintf('[surrogate_standard] Calculated standard surrogate \n');
end

