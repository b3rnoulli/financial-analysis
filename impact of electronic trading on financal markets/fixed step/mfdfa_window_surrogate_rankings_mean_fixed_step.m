clear
clc
indexes = {
    'SP500-removed',         '01-Jan-1950', '31-Dec-2016';
    'DJIA',        '01-Jan-1950', '10-Dec-2017';
    };

frame_size = 5000;
frame_step_size = 20;

surrogate_count = 100;

surrogates_per_window = 100;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/'];
    data = load(indexes{i,1});
    
    start_index = 1;
    end_index = frame_size;
    
    while end_index < length(data.returns)
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
       
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        
    end
   
end