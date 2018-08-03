indexes = {
%     'SP500-removed',  datetime('03-Jan-1950'), datetime('03-Jan-1987'), datetime('29-Dec-2016'), 30, 160, 300, 700;
    'NASDAQ-removed', datetime('03-Jan-1950'), datetime('03-Jan-1987'), datetime('29-Dec-2016'), 23, 120, 500, 1000;
    };

surrogates_per_window = 100;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/'];

    % sp 500
%     calculate_mean_spectrum(indexes{i,1},indexes{i,2},indexes{i,3},indexes{i,5},indexes{i,6},indexes{i,7},indexes{i,8},path);
%     calculate_mean_spectrum(indexes{i,1},indexes{i,2},indexes{i,4},indexes{i,5},indexes{i,6},indexes{i,7},indexes{i,8},path);
%     calculate_mean_spectrum(indexes{i,1},indexes{i,3},indexes{i,4},30 ,300,indexes{i,7},indexes{i,8},path);

    calculate_mean_spectrum(indexes{i,1},indexes{i,2},indexes{i,3},23, 124,indexes{i,7},indexes{i,8},path);
    calculate_mean_spectrum(indexes{i,1},indexes{i,2},indexes{i,4},21, 200,indexes{i,7},indexes{i,8},path);
    calculate_mean_spectrum(indexes{i,1},indexes{i,3},indexes{i,4},25, 180 ,indexes{i,7},indexes{i,8},path);
end


function calculate_mean_spectrum(index_name, start_date, end_date, bottom_rankings, upper_rankings, bottom_bound, upper_bound, path)
    surrogates_per_window=100;
    fprintf('[specmulti_window_script] : Calculating MFDFA for index %s date scope %s to %s\n', index_name,...
        datestr(start_date), datestr(end_date));
    fourier_spectrum_file_name = [index_name,'-fourier-surrogate-spectrum-',datestr(start_date,'yyyy-mm-dd'),...
        '-',datestr(end_date,'yyyy-mm-dd')];
    
    rankings_spectrum_file_name = [index_name,'-rankings-surrogate-spectrum-',datestr(start_date,'yyyy-mm-dd'),...
        '-',datestr(end_date,'yyyy-mm-dd')];
    
    fourier_spectrum_data = load([path, fourier_spectrum_file_name]);
    fourier_surrogate_scales = zeros(surrogates_per_window, 41);
    fourier_surrogate_fq = zeros(surrogates_per_window, 41, 100);
    
    rankings_spectrum_data = load([path, rankings_spectrum_file_name]);
    rankings_surrogate_scales = zeros(surrogates_per_window, 41);
    rankings_surrogate_fq = zeros(surrogates_per_window, 41, 100);
    
    for j=1:surrogates_per_window
        fourier_surrogate_scales(j,:) = fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(j).Scale;
        fourier_surrogate_fq(j,:,:) = fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(j).Fq;
        
        rankings_surrogate_scales(j,:) = rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(j).Scale;
        rankings_surrogate_fq(j,:,:) = rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(j).Fq;
    end
    
    save_path = [path,'/mean/'];
    fourier_surrogate_mean_file_name = [save_path,index_name,'-fourier-surrogate-mean-spectrum-',datestr(start_date,'yyyy-mm-dd'),...
        '-',datestr(end_date,'yyyy-mm-dd')];
    fourier_surrogate_fq=real(fourier_surrogate_fq);
    MFDFA2.q = -10:0.2:10;
    MFDFA2.q(51) = [];
    MFDFA2.Scale = mean(fourier_surrogate_scales);
    MFDFA2.Fq = reshape(mean(fourier_surrogate_fq),41,100);
    MFDFA2.Fq_std = reshape(std(fourier_surrogate_fq),41,100);
    save(fourier_surrogate_mean_file_name,'MFDFA2');
    
    fourier_spectrum_data = load(fourier_surrogate_mean_file_name);
    MFDFA2 = specmulti(fourier_spectrum_data.MFDFA2, [], bottom_bound, upper_bound);
    MFDFA2.Fq_std = reshape(std(fourier_surrogate_fq),41,100);
    save(fourier_surrogate_mean_file_name,'MFDFA2');
    
    rankings_surrogate_mean_file_name = [save_path,index_name,'-rankings-surrogate-mean-spectrum-',datestr(start_date,'yyyy-mm-dd'),...
        '-',datestr(end_date,'yyyy-mm-dd')];
    
    MFDFA2.q = -10:0.2:10;
    MFDFA2.q(51) = [];
    MFDFA2.Scale = mean(rankings_surrogate_scales);
    MFDFA2.Fq = reshape(mean(rankings_surrogate_fq),41,100);
    MFDFA2.Fq_std = reshape(std(rankings_surrogate_fq),41,100);
    save(rankings_surrogate_mean_file_name,'MFDFA2');
    
    rankings_spectrum_data = load(rankings_surrogate_mean_file_name);
    MFDFA2 = specmulti(rankings_spectrum_data.MFDFA2, [], bottom_rankings, upper_rankings);
    MFDFA2.Fq_std = reshape(std(rankings_surrogate_fq),41,100);
    save(rankings_surrogate_mean_file_name,'MFDFA2');

end


