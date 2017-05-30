function [ index ] = find_index(available_dates, searched_date)
fprintf('[find_index]: Finding index of date %s \n', datestr(searched_date));
searched_date_number = datenum(searched_date);
available_date_number = datenum(available_dates);
difference = available_date_number-searched_date_number;
index = find(difference > 0,1);
if isempty(difference(difference>0))
    index = length(available_dates)-1;
end
fprintf('[find_index]: Found index of date %s. Result %d - its represent date %s \n',...
    datestr(searched_date), index, datestr(available_dates(index)));
end

