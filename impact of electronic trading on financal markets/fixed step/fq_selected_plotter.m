clear
clc
index_name='NASDAQ-removed';
data = load(index_name);

end_dates = {datetime('21-Oct-1974'), datetime('11-Nov-1987'),datetime('23-Jul-1993'), datetime('20-Jul-1998'), datetime('21-Aug-2001')};

frame_size=2500;


for i=1:1:length(end_dates)
    
    
    end_index=find_index(data.date,end_dates{i});
    start_index=end_index-frame_size;
    
    spectrum_file_name = [index_name,'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
        '-',datestr(data.date(end_index),'yyyy-mm-dd')];
    spectrum_data = load(spectrum_file_name);
    
    figure
    loglog(spectrum_data.MFDFA2.Scale,spectrum_data.MFDFA2.Fq(1:41,31:70),'k');
    axis tight
    title(['NASDAQ - ',num2str(i),' -',datestr(data.date(start_index),'yyyy-mm-dd'),...
        '-',datestr(data.date(end_index),'yyyy-mm-dd')]);
    set(gca,'FontSize',16);
    ylim([0 20]);
    xlim([35 450])
end