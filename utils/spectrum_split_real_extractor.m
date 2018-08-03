indexes = {
    'SP500-removed','01-Jan-1950', '02-Jan-1987', 29, 230;
    'SP500-removed','01-Jan-1950', '31-Dec-2016', 29, 230;
    'SP500-removed','02-Jan-1987', '31-Dec-2016', 29, 230;
    'NASDAQ-removed','01-Jan-1950', '02-Jan-1987', 29, 230;
    'NASDAQ-removed','01-Jan-1950', '31-Dec-2016', 29, 230;
    'NASDAQ-removed','02-Jan-1987', '31-Dec-2016', 29, 230;
    'DJIA','01-Jan-1950', '02-Jan-1987', 29, 230;
    'DJIA','01-Jan-1950', '31-Dec-2016', 29, 230;
    'DJIA','02-Jan-1987', '31-Dec-2016', 29, 230;
    };


for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/mean/'];
    data = load(indexes{i,1});
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = find_index(data.date,indexes{i,3});
    
    fprintf('[specmulti_window_script] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
        datestr(data.date(start_index)), datestr(data.date(end_index)));
    fourier_spectrum_file_name = [indexes{i,1},'-fourier-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
        '-',datestr(data.date(end_index),'yyyy-mm-dd')];
    
    load(fourier_spectrum_file_name);
    MFDFA2.Fq = real(MFDFA2.Fq);
    
    save([path,fourier_spectrum_file_name],'MFDFA2');
    
    end