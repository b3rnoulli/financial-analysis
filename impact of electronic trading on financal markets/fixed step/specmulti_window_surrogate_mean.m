indexes = {
%     'SP500-removed',  datetime('03-Jan-1950'), datetime('03-Jan-1987'), datetime('29-Dec-2016'), 23, 180, 300, 700;
%     'DJIA',           datetime('03-Jan-1950'), datetime('02-Jan-1987'), datetime('03-Jan-2017'), 34,400, 300, 700;
    'NASDAQ-removed', datetime('03-Jan-1950'), datetime('03-Jan-1987'), datetime('29-Dec-2016'), 28,200, 300, 700;
    };

save_figures = false;
write_to_file = false;
plot_surrogates = true;

for i=1:1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/'];
    
    % first part
    rankings_spectrum_file_name = [indexes{i,1},'-rankings-surrogate-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,3},'yyyy-mm-dd')];
    rankings_spectrum_data = load([rankings_spectrum_file_name,'.mat']);
    
    fourier_spectrum_file_name = [indexes{i,1},'-fourier-surrogate-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,3},'yyyy-mm-dd')];
    fourier_spectrum_data = load([fourier_spectrum_file_name,'.mat']);
    
    for j=1:1:length(rankings_spectrum_data.rankings_surrogate_mfdfa_matrix)
        rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(i) = specmulti(rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(i),[],indexes{i,5},indexes{i,6});
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).Fq = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).Fq);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).h = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).h);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).T = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).T);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).alfa = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).alfa);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).f = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).f);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i) = specmulti(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i),[],indexes{i,7},indexes{i,8});
    end
    
    rankings_surrogate_mfdfa_matrix=rankings_spectrum_data.rankings_surrogate_mfdfa_matrix;
    save([path,rankings_spectrum_file_name,'_test'],'rankings_surrogate_mfdfa_matrix');
    
    fourier_surrogate_mfdfa_matrix=fourier_spectrum_data.fourier_surrogate_mfdfa_matrix;
    save([path,fourier_spectrum_file_name],'fourier_surrogate_mfdfa_matrix');
    
    % second part
    rankings_spectrum_file_name = [indexes{i,1},'-rankings-surrogate-spectrum-',datestr(indexes{i,3},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,4},'yyyy-mm-dd')];
    rankings_spectrum_data = load([rankings_spectrum_file_name,'.mat']);
    
    fourier_spectrum_file_name = [indexes{i,1},'-fourier-surrogate-spectrum-',datestr(indexes{i,3},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,4},'yyyy-mm-dd')];
    fourier_spectrum_data = load([fourier_spectrum_file_name,'.mat']);
    
    for j=1:1:length(rankings_spectrum_data.rankings_surrogate_mfdfa_matrix)
        rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(i) = specmulti(rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(i),[],indexes{i,5},indexes{i,6});
        
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).Fq = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).Fq);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).h = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).h);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).T = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).T);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).alfa = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).alfa);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).f = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).f);
        
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i) = specmulti(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i),[],indexes{i,7},indexes{i,8});
    end
    
    rankings_surrogate_mfdfa_matrix=rankings_spectrum_data.rankings_surrogate_mfdfa_matrix;
    save([path,rankings_spectrum_file_name],'rankings_surrogate_mfdfa_matrix');
    
    fourier_surrogate_mfdfa_matrix=fourier_spectrum_data.fourier_surrogate_mfdfa_matrix;
    save([path,fourier_spectrum_file_name],'fourier_surrogate_mfdfa_matrix');
    
    
    % whole data
    rankings_spectrum_file_name = [indexes{i,1},'-rankings-surrogate-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,4},'yyyy-mm-dd')];
    rankings_spectrum_data = load([rankings_spectrum_file_name,'.mat']);
    
    fourier_spectrum_file_name = [indexes{i,1},'-fourier-surrogate-spectrum-',datestr(indexes{i,2},'yyyy-mm-dd'),...
        '-', datestr(indexes{i,4},'yyyy-mm-dd')];
    fourier_spectrum_data = load([fourier_spectrum_file_name,'.mat']);
    
    for j=1:1:length(rankings_spectrum_data.rankings_surrogate_mfdfa_matrix)
        rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(i) = specmulti(rankings_spectrum_data.rankings_surrogate_mfdfa_matrix(i),[],indexes{i,5},indexes{i,6});
        
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).Fq = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).Fq);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).h = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).h);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).T = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).T);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).alfa = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).alfa);
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).f = real(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i).f);
        
        fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i) = specmulti(fourier_spectrum_data.fourier_surrogate_mfdfa_matrix(i),[],indexes{i,7},indexes{i,8});
    end
    
   
    rankings_surrogate_mfdfa_matrix=rankings_spectrum_data.rankings_surrogate_mfdfa_matrix;
    save([path,rankings_spectrum_file_name],'rankings_surrogate_mfdfa_matrix');
    
    fourier_surrogate_mfdfa_matrix=fourier_spectrum_data.fourier_surrogate_mfdfa_matrix;
    save([path,fourier_spectrum_file_name],'fourier_surrogate_mfdfa_matrix');
    
    
end