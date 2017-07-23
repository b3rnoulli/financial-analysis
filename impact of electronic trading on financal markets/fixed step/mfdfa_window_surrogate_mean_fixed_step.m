indexes = {
    'SP500-removed',datetime('01-Jan-1950'), datetime('31-Dec-2016'), 29, 230;
    'NASDAQ-removed',datetime('01-Jan-1950'), datetime('31-Dec-2016'), 30, 208;
    };

frame_size = 5000;
frame_step_size = 20;

surrogates_per_window = 100;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/'];
    data = load(indexes{i,1});
    
    start_index = 1;
    end_index = frame_size;
    
    while end_index < length(data.returns)
        fprintf('[specmulti_window_script] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        fourier_spectrum_file_name = [indexes{i,1},'-fourier-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        fourier_spectrum_data = load([path, fourier_spectrum_file_name]);
        fourier_surrogate_scales = zeros(surrogates_per_window, 41);
        fourier_surrogate_fq = zeros(surrogates_per_window, 41, 100);
        
        shuffled_surrogate_data = load([path, indexes{i,1},'-shuffled-surrogate-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')]);
        shuffled_surrogate_scales = zeros(surrogates_per_window, 41);
        shuffled_surrogate_fq = zeros(surrogates_per_window, 41, 100);
        
        for j=1:surrogates_per_window
            fourier_surrogate_scales(j,:) = fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(j).Scale;
            fourier_surrogate_fq(j,:,:) = fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(j).Fq;
            
            shuffled_surrogate_scales(j,:) = shuffled_surrogate_data.shuffled_surrogate_mfdfa_matrix(j).Scale;
            shuffled_surrogate_fq(j,:,:) = shuffled_surrogate_data.shuffled_surrogate_mfdfa_matrix(j).Fq;    
            
        end
        
        save_path = [path,'/mean/'];
        fourier_surrogate_mean_file_name = [save_path,indexes{i,1},'-fourier-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        MFDFA2.q = -10:0.2:10;
        MFDFA2.q(51) = [];
        MFDFA2.Scale = mean(fourier_surrogate_scales);
        MFDFA2.Fq = reshape(mean(fourier_surrogate_fq),41,100);
        save(fourier_surrogate_mean_file_name,'MFDFA2');
        
        shuffled_surrogate_mean_file_name = [save_path,indexes{i,1},'-shuffled-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        MFDFA2.Scale = mean(shuffled_surrogate_scales);
        MFDFA2.Fq = reshape(mean(shuffled_surrogate_fq),41,100);
        save(shuffled_surrogate_mean_file_name,'MFDFA2');
        
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        
    end
   
end