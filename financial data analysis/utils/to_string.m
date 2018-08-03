function [ string_value ] = to_string( value )

string_value='';
if isnumeric(value)
    string_value = num2str(value);
elseif isdatetime(value)
    string_value=datestr(value,'yyyy-mm-dd');
elseif isempty(value)
    string_value='';
else
    ex = MException('Cannot convert value', value);
    throw(ex);
end

end

