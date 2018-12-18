% index name, start year, end year
clear
clc
indexes = {
    '9-companies',         '01-Jan-1950', '31-Dec-2016';
    'NASDAQ-removed',                  '01-Jan-1950', '31-Dec-2016';
    };

frame_size = 5000;
frame_step_size = 20;

surrogate_count = 100;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/'];
    data = load(indexes{i,1});
    
    start_index = 1;
    end_index = frame_size;
    
    while end_index < length(data.returns)
        fprintf('[surrogate_mfdfa_script] : Calculating MFDFA for surrogate index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        
        rankings_surrogate_file_name = [indexes{i,1},'-rankings-surrogate-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        rankings_surrogate_data = load(rankings_surrogate_file_name);
        
        parfor j=1:surrogate_count
            rankings_surrogate_mfdfa_matrix(j) = MFDFA(rankings_surrogate_data.rankings_surrogate_matrix(j,:),' not_used', false);
        end
        
        rankings_surrogate_mfdfa_file_name =  [indexes{i,1},'-rankings-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        save([path,rankings_surrogate_mfdfa_file_name],'rankings_surrogate_mfdfa_matrix');
        
        clear rankings_surrogate_mfdfa_matrix
        
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
    end
end
