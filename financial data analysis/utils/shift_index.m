function [ index ] = shift_index(available_dates, start_index, shift_by, shift_type)

start_date = available_dates(start_index);
fprintf('[shift_index]: Shifting date %s by %s using mode %s \n', datestr(start_date), num2str(shift_by), shift_type);

if strcmp(shift_type,'WEEK')
    nearest_monday = dateshift(start_date,'start','week','nearest')+1;
    result_day = dateshift(nearest_monday,'start','week',shift_by);
elseif strcmp(shift_type,'YEAR')
    result_day = dateshift(start_date,'start','year',shift_by);
elseif strcmp(shift_type,'DAY')
    result_day = start_date + days(shift_by);
elseif strcmp(shift_type,'MONTH')
    result_day = dateshift(start_date,'start','month',shift_by);
else
    throw(MException('Shit type not specified!'));
end

index = find_index(available_dates,result_day);
fprintf('[shift_index]: Shifted date %s by %s using mode %s. Result %s \n', datestr(start_date), num2str(shift_by), shift_type, datestr(result_day));

end

