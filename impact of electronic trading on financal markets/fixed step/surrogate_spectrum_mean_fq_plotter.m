indexes = {
    'SP500-removed',  datetime('03-Jan-1950'), datetime('03-Jan-1987'), datetime('29-Dec-2016'), 34, 230, 300, 700;
%     'NASDAQ-removed', datetime('03-Jan-1950'), datetime('03-Jan-1987'), datetime('29-Dec-2016'), 23, 120, 500, 900;
    };


f1 = figure('units','normalized','position',[.1 .1 .6 .6]);
f2 = figure('units','normalized','position',[.1 .1 .6 .6]);
for i=1:1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/surrogate/'];
 
    plot_part(indexes{i,1}, indexes{i,2},indexes{i,3},'b',f1,f2);
    plot_part(indexes{i,1}, indexes{i,3},indexes{i,4},'k',f1,f2);
    plot_part(indexes{i,1}, indexes{i,2},indexes{i,4},'r',f1,f2);

    figure(f1);
    legend show
    figure(f2);
    legend show
end

function plot_part(index_name, start_date, end_date, color, f1, f2)
 rankings_spectrum_file_name = [index_name,'-rankings-surrogate-mean-spectrum-',datestr(start_date,'yyyy-mm-dd'),...
        '-', datestr(end_date,'yyyy-mm-dd')];
    rankings_spectrum_data = load([rankings_spectrum_file_name,'.mat']);
    rankings_spectrum_data=rankings_spectrum_data.MFDFA2;
    
    fourier_spectrum_file_name = [index_name,'-fourier-surrogate-mean-spectrum-',datestr(start_date,'yyyy-mm-dd'),...
        '-', datestr(end_date,'yyyy-mm-dd')];
    fourier_spectrum_data = load([fourier_spectrum_file_name,'.mat']);
    fourier_spectrum_data=fourier_spectrum_data.MFDFA2;
    
    p = spectrum_plotter(f1, rankings_spectrum_data.alfa(31:70), rankings_spectrum_data.f(31:70), 'x-', color, [ index_name,'-rankings-', datestr(start_date,'yyyy'),'-',datestr(end_date,'yyyy')]);
    
    p = spectrum_plotter(f2, fourier_spectrum_data.alfa(31:70), fourier_spectrum_data.f(31:70), 'x-', color, [ index_name,'-fourier-', datestr(start_date,'yyyy'),'-',datestr(end_date,'yyyy')]);

    %save
    
    
end