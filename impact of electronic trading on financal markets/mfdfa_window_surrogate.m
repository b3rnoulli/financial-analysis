% index name, start year, end year
clear
indexes = {
    'SP500-removed',         '01-Jan-1950', '31-Dec-2016';
    'NASDAQ-removed',        '01-Jan-1950', '31-Dec-2016';
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';

surrogate_count = 10;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/'];
    data = load(indexes{i,1});
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);
    
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[surrogate_mfdfa_script] : Calculating MFDFA for surrogate index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        
        fourier_surrogate_file_name = [indexes{i,1},'-fourier-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        shuffled_surrogate_file_name = [indexes{i,1},'-shuffled-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        
        fourier_surrogate_data = load(fourier_surrogate_file_name);
        shuffled_surrogate_data = load(shuffled_surrogate_file_name);
        
        parfor j=1:surrogate_count
            fourier_surrogate_mfdfa_matrix(j) = MFDFA(fourier_surrogate_data.fourier_surrogate_matrix(j,:),' not_used', false);
            shuffled_surrogate_mfdfa_matrix(j) = MFDFA(shuffled_surrogate_data.shuffled_surrogate_matrix(j,:),'not_used', false);       
        end
        
        fourier_surrogate_mfdfa_file_name =  [indexes{i,1},'-fourier-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        shuffled_surrogate_mfdfa_file_name =  [indexes{i,1},'-shuffled-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        save([path,fourier_surrogate_mfdfa_file_name],'fourier_surrogate_mfdfa_matrix');
        save([path,shuffled_surrogate_mfdfa_file_name],'shuffled_surrogate_mfdfa_matrix');
        
        clear fourier_surrogate_mfdfa_matrix shuffled_surrogate_mfdfa_matrix
        
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
    end
end
