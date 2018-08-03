symbols = {
    %     'HON'
    %     'DD'
    %     'GE'
    %     'GT'
    %     'NAV'
    %     'IP'
    %     'PG'
    %     'CVX'
    %     'XOM'
    %     'UTX'
    %     'AA'
    %     'MMM'
    %     'IBM'
    %     'MERC'
    %     'AXP'
    %     'MO'
    %     'MCD'
    %     'KO'
    %     'BA'
    %     'CAT'
    %     'DIS'
    %     'JPM'
    %     'JNJ'
    %     'HPQ'
    %     'C'
    %     'WMT'
    %     'INTC'
    %     'HD'
    %     'MSFT'
    %     'AIG'
    %     'PFE'
    %     'VZ'
    %     'BAC'
    %     'TRV'
    'UNH'
    %     'CSCO'
    %     'GS'
    %     'V'
    %     'NKE'
    %     'AAPL'
    };


for i=1:length(symbols)
    display_symbol(symbols{i});
    try
        fileID = fopen([get_root_path(),'/financial-analysis/empirical data/',symbols{i},'/',symbols{i},'.csv']);
        scanned_text = textscan(fileID,'%s','Delimiter','\n');
        scanned_text = scanned_text{1,1};
        
        date = datetime('02-Jan-1970');
        open = zeros(1, length(scanned_text)-1);
        highest = zeros(1, length(scanned_text)-1);
        lowest = zeros(1, length(scanned_text)-1);
        close = zeros(1, length(scanned_text)-1);
        close_adjusted = zeros(1, length(scanned_text)-1);
        volume = zeros(1, length(scanned_text)-1);
        for j=2:1:length(scanned_text)
            splitted_cells = strsplit(scanned_text{j},',');
            date(j-1) = datetime(splitted_cells{1},'InputFormat','yyyy-MM-dd');
            open(j-1) = str2double(splitted_cells{2});
            highest(j-1) = str2double(splitted_cells{3});
            lowest(j-1) = str2double(splitted_cells{4});
            close(j-1) = str2double(splitted_cells{5});
            close_adjusted(j-1) = str2double(splitted_cells{6});
            volume(j-1) = str2double(splitted_cells{7});
        end
        fclose(fileID);
        returns = zscore(diff(log(close)));
        returns_adjusted = zscore(diff(log(close_adjusted)));
        parsave(symbols{i}, date, open,close, close_adjusted, highest,lowest,volume, returns,returns_adjusted);
    catch
        fclose(fileID);
    end
    
end

function parsave(symbol, date, open,close, close_adjusted, highest,lowest,volume, returns,returns_adjusted)
save([get_root_path(),'/financial-analysis/empirical data/',symbol,'/',symbol,'.mat'],'date','open','close','close_adjusted',...
    'highest','lowest','volume', 'returns','returns_adjusted');
end

function display_symbol(symbol)
fprintf('Importing symbol %s \n', symbol)
end


