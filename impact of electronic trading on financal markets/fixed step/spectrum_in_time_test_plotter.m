date_vector=full_data_points(1).date;
figure;
for i=1:length(full_data_points)
    for j=1:1:41
        date_vector(j) = full_data_points(i).date;
    end
    plot(date_vector, full_data_points(i).points,'k');
    hold  on;
    plot(date_vector(1), full_data_points(i).points(full_data_points(i).max_index),'xr');

end