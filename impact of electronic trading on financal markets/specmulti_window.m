% indexes = {
%     'AAPL',           datetime('01-Jan-1985'), datetime('31-Dec-2016'), 40, 280;
%     'BRKA',           datetime('01-Jan-1985'), datetime('31-Dec-2016'), 40, 275;
%     'DIS',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 33, 223;
%     'GE',             datetime('01-Jan-1985'), datetime('31-Dec-2016'), 45, 230;
%     'INTC',           datetime('01-Jan-1985'), datetime('31-Dec-2016'), 25, 240;
%     'IP',             datetime('01-Jan-1985'), datetime('31-Dec-2016'), 30, 186;
%     'JPM',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 32, 280;
%     'PG',             datetime('01-Jan-1985'), datetime('31-Dec-2016'), 32, 650;
%     'PFE',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 30, 165;
%     'T',              datetime('01-Jan-1985'), datetime('31-Dec-2016'), 54, 470;
%     'TXN',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 35, 250;
%     'XOM',            datetime('01-Jan-1985'), datetime('31-Dec-2016'), 35, 250;
%     };


%nasdaq
% indexes = {
%        'AAPL', '01-Jan-1985', '31-Dec-2016', 40, 279;
%        'MSFT', '01-Jan-1985', '31-Dec-2016', 37, 205;
%        'CMCSA','01-Jan-1985', '31-Dec-2016', 37, 190;
%        'INTC', '01-Jan-1985', '31-Dec-2016', 40, 200;
%        'CSCO', '01-Jan-1985', '31-Dec-2016', 38, 250;
%        'AMGN', '01-Jan-1985', '31-Dec-2016', 32, 105;
%        'WBA',  '01-Jan-1985', '31-Dec-2016', 33, 210;
%        'TXN',  '01-Jan-1985', '31-Dec-2016', 35, 250;
%        'COST', '01-Jan-1985', '31-Dec-2016', 37, 447;
%        'ADBE', '01-Jan-1985', '31-Dec-2016', 42, 208;
%     };


%DJIA
% indexes = {
%     'AA',  '01-Jan-1981', '31-Dec-2016',34,194;
%     'AIG', '01-Jan-1981', '31-Dec-2016',41,243;
%     'AXP', '01-Jan-1981', '31-Dec-2016',47,464;
%     'C',   '01-Jan-1981', '31-Dec-2016',36,405;
%     'CVX', '01-Jan-1981', '31-Dec-2016',45,262;
%     'DD',  '01-Jan-1981', '31-Dec-2016',39,254;
%     'DIS', '01-Jan-1981', '31-Dec-2016',37,469;
%     'GE',  '01-Jan-1981', '31-Dec-2016',51,431;
%     'GT',  '01-Jan-1981', '31-Dec-2016',37,262;
%     'HON', '01-Jan-1981', '31-Dec-2016',34,668;
%     'HPQ', '01-Jan-1981', '31-Dec-2016',42,291;
%     'IBM', '01-Jan-1981', '31-Dec-2016',37,238;
%     'INTC','01-Jan-1981', '31-Dec-2016',56,309;
%     'IP',  '01-Jan-1981', '31-Dec-2016',35,200;
%     'JNJ', '01-Jan-1981', '31-Dec-2016',51,405;
%     'KO',  '01-Jan-1981', '31-Dec-2016',54,538;
%     'MCD', '01-Jan-1981', '31-Dec-2016',70,418;
%     'MO',  '01-Jan-1981', '31-Dec-2016',41,405;
%     'PG',  '01-Jan-1981', '31-Dec-2016',54,559;
%     'PFE', '01-Jan-1981', '31-Dec-2016',44,262;
%     'UTX', '01-Jan-1981', '31-Dec-2016',46,450;
%     'WMT', '01-Jan-1981', '31-Dec-2016',48,504;
%     'XOM', '01-Jan-1981', '31-Dec-2016',40,246;
%     'UTX', '01-Jan-1981', '31-Dec-2016',42,427;
%     'NAV', '01-Jan-1981', '31-Dec-2016',48,577;
%     'MMM', '01-Jan-1981', '31-Dec-2016',48,262;
%     'BA',  '01-Jan-1981', '31-Dec-2016',37,469;
%     'BAC', '01-Jan-1981', '31-Dec-2016',31,373;
%     };

indexes = {
    'DJIA-RR-3', '01-Jan-1981', '31-Dec-2016', 35, 450;
};

frame_size = 20;
frame_size_type = 'YEAR';
frame_step_size = 1;
frame_step_type = 'MONTH';

for i=1:length(indexes(:,1))
    path = [get_root_path(),'/financial-analysis/empirical data/',indexes{i,1},'/spectrum/window/'];
    data = load(indexes{i,1});
    
    start_index = find_index(data.date,indexes{i,2});
    end_index = shift_index(data.date, start_index, frame_size, frame_size_type);
    
    while end_index < find_index(data.date,indexes{i,3})
        fprintf('[specmulti_window_script] : Calculating MFDFA for index %s date scope %s to %s\n', indexes{i,1},...
            datestr(data.date(start_index)), datestr(data.date(end_index)));
        spectrum_file_name = [indexes{i,1},'-spectrum-',datestr(data.date(start_index),'yyyy-mm-dd'),...
            '-',datestr(data.date(end_index),'yyyy-mm-dd')];
        
        spectrum_data = load([path, spectrum_file_name]);
        specmulti(spectrum_data.MFDFA2, [path, spectrum_file_name], indexes{i,4}, indexes{i,5});
        
        start_index = shift_index(data.date, start_index, frame_step_size, frame_step_type);
        end_index = shift_index(data.date, end_index, frame_step_size, frame_step_type);
    end
end