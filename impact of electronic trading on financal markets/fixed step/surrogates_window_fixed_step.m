% index name, start year, end year
indexes = {
    'SP500-removed', '01-Jan-1950', '31-Dec-2016';
    'DJIA',        '01-Jan-1950', '31-Dec-2016';
    'NASDAQ',        '01-Jan-1950', '31-Dec-2016';
    };

frame_size = 5000;
frame_step_size = 20;

surrogate_count = 100;

for i=1:length(indexes(:,1))

    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/surrogate/window/'];
    data = load(indexes{i,1});
        
    start_index = 1;
    end_index = frame_size;
    
    while end_index < length(data.returns)
        fprintf('[surrogate_window_script] : Calculating surrogates for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        
        fourier_surrogate_file_name = [indexes{i,1},'-fourier-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        shuffled_surrogate_file_name = [indexes{i,1},'-shuffled-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        shuffled_surrogate_matrix = zeros(surrogate_count,end_index-start_index+1);
        fourier_surrogate_matrix = zeros(surrogate_count,end_index-start_index+1);
        
        for j=1:surrogate_count   
            fourier_surrogate_matrix(j,:) = surrogate_fourier(data.returns(start_index:end_index));
            shuffled_surrogate_matrix(j,:) = surrogate_standard(data.returns(start_index:end_index));
        end
        
        save([path,fourier_surrogate_file_name],'fourier_surrogate_matrix');
        save([path,shuffled_surrogate_file_name],'shuffled_surrogate_matrix');
        
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        
    end
end
