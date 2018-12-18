% index name, start year, end year
% indexes = {
%        'AAPL', '01-Jan-1985', '31-Dec-2016';
%        'BRKA', '01-Jan-1985', '31-Dec-2016';
%        'DIS',  '01-Jan-1985', '31-Dec-2016';
%        'GE',   '01-Jan-1985', '31-Dec-2016';
%        'INTC', '01-Jan-1985', '31-Dec-2016';
%        'IP',   '01-Jan-1985', '31-Dec-2016';
%        'JPM',  '01-Jan-1985', '31-Dec-2016';
%        'PFE',  '01-Jan-1985', '31-Dec-2016';
%        'PG',   '01-Jan-1985', '31-Dec-2016';
%        'T',    '01-Jan-1985', '31-Dec-2016';
%        'TXN',  '01-Jan-1985', '31-Dec-2016';
%        'XOM',  '01-Jan-1985', '31-Dec-2016';
%     };

%nasdaq
% indexes = {
%        'AAPL', '01-Jan-1985', '31-Dec-2016';
%        'MSFT', '01-Jan-1985', '31-Dec-2016';
%        'CMCSA','01-Jan-1985', '31-Dec-2016';
%        'INTC', '01-Jan-1985', '31-Dec-2016';
%        'CSCO', '01-Jan-1985', '31-Dec-2016';
%        'AMGN', '01-Jan-1985', '31-Dec-2016';
%        'WBA',  '01-Jan-1985', '31-Dec-2016';
%        'TXN',  '01-Jan-1985', '31-Dec-2016';
%        'COST', '01-Jan-1985', '31-Dec-2016';
%        'ADBE', '01-Jan-1985', '31-Dec-2016';
%     };

%DJIA
% indexes = {
%     'AA',  '01-Jan-1981', '31-Dec-2016';
%     'AIG', '01-Jan-1981', '31-Dec-2016';
%     'AXP', '01-Jan-1981', '31-Dec-2016';
%     'C',   '01-Jan-1981', '31-Dec-2016';
%     'CVX', '01-Jan-1981', '31-Dec-2016';
%     'DD',  '01-Jan-1981', '31-Dec-2016';
%     'DIS', '01-Jan-1981', '31-Dec-2016';
%     'GE',  '01-Jan-1981', '31-Dec-2016';
%     'GT',  '01-Jan-1981', '31-Dec-2016';
%     'HON', '01-Jan-1981', '31-Dec-2016';
%     'HPQ', '01-Jan-1981', '31-Dec-2016';
%     'IBM', '01-Jan-1981', '31-Dec-2016';
%     'INTC','01-Jan-1981', '31-Dec-2016';
%     'IP',  '01-Jan-1981', '31-Dec-2016';
%     'JNJ', '01-Jan-1981', '31-Dec-2016';
%     'KO',  '01-Jan-1981', '31-Dec-2016';
%     'MCD', '01-Jan-1981', '31-Dec-2016';
%     'MO',  '01-Jan-1981', '31-Dec-2016';
%     'PG',  '01-Jan-1981', '31-Dec-2016';
%     'PFE', '01-Jan-1981', '31-Dec-2016';
%     'UTX', '01-Jan-1981', '31-Dec-2016';
%     'WMT', '01-Jan-1981', '31-Dec-2016';
%     'XOM', '01-Jan-1981', '31-Dec-2016';
%     'UTX', '01-Jan-1981', '31-Dec-2016';
%     'NAV', '01-Jan-1981', '31-Dec-2016';
%     'MMM', '01-Jan-1981', '31-Dec-2016';
%     'BA',  '01-Jan-1981', '31-Dec-2016';
%     'BAC', '01-Jan-1981', '31-Dec-2016';
%     };

indexes = {
%     'NDX',  '01-Jan-1981', '31-Dec-2016';
%     'IXIC', '01-Jan-1972', '31-Dec-2016';
      'NASDAQ-removed-2', '01-Jan-1950', '31-Dec-2016';
};

frame_size = 240;
frame_size_type = 'MONTH';
frame_step_size = 1;
frame_step_type = 'MONTH';

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load([indexes{i,1}]);
    
    mkdir([get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/']);
    
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);
    
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[mfdfa_windows_script] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index),'yyyy-mm-dd'), datestr(data.date(end_index),'yyyy-mm-dd'));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        MFDFA(data.returns(start_index:end_index), [path,spectrum_file_name]);
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
    end
end
