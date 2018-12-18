indexes = {
    'SP500-removed',datetime('01-Jan-1950'), datetime('31-Dec-2016'), 29, 230;
    'NASDAQ-removed',datetime('01-Jan-1950'), datetime('31-Dec-2016'), 30, 208;
    };

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';

surrogates_per_window = 1;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/'];
    data = load(indexes{i,1});
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);
    
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[specmulti_window_script] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        rankings_spectrum_file_name = [indexes{i,1},'-rankings-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        rankings_spectrum_data = load([path, rankings_spectrum_file_name]);
        rankings_surrogate_scales = zeros(surrogates_per_window, 41);
        rankings_surrogate_fq = zeros(surrogates_per_window, 41, 100);

        
        for j=1:surrogates_per_window
            rankings_surrogate_scales(j,:) = rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(j).Scale;
            rankings_surrogate_fq(j,:,:) = rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(j).Fq;
        end
        
        save_path = [path,'/mean/'];
        rankings_surrogate_mean_file_name = [save_path,indexes{i,1},'-rankings-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        MFDFA2.q = -10:0.2:10;
        MFDFA2.q(51) = [];
        MFDFA2.Scale = (rankings_surrogate_scales);
        MFDFA2.Fq = reshape((rankings_surrogate_fq),41,100);
        save(rankings_surrogate_mean_file_name,'MFDFA2');
       
        
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
        
    end
   
end