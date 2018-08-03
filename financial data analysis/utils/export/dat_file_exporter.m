function [] = dat_file_exporter(data, file_name)

fid = fopen([file_name,'.dat'], 'w') ;

for i=1:1:length(data)
    fields = fieldnames(data(i));
    line = '';
    for j=1:numel(fields)
        field_value_as_string = to_string(data(i).(fields{j}));
        line = [line,' ',field_value_as_string];
    end
    fprintf(fid,[line,'\n']);
    
end
fclose(fid);

end

