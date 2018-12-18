indexes = {
   '9-companies',datetime('01-Jan-1950'), datetime('31-Dec-2016'), 29, 230;
%    'DJIA',datetime('01-Jan-1950'), datetime('31-Dec-2016'), 30, 208;
    };

frame_size = 5000;
frame_step_size = 20;

surrogates_per_window = 100;

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/mean/'];
    data = load(indexes{i,1});
    
    start_index = 1;
    end_index = frame_size;
    
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[specmulti_window_script] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        fourier_spectrum_file_name = [indexes{i,1},'-fourier-surrogate-mean-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        load(fourier_spectrum_file_name);
        MFDFA2.Fq = real(MFDFA2.Fq);
        
        save([path,fourier_spectrum_file_name],'MFDFA2');
        
        start_index = start_index + frame_step_size;
        end_index = end_index + frame_step_size;
        
    end
    
end


