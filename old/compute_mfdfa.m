function compute_mfdfa(data, index_name, path, start_index, end_index )
        fprintf('compute_mfdfa : Calculating MFDFA for index %s date scope %s to %s\n', index_name,...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [index_name,'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        log_return_rates = zscore(diff(log(data.price)));
        MFDFA(log_return_rates(start_index :end_index), [path,spectrum_file_name]);
end

