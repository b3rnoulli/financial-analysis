symbols = {'SP500-removed-2','SP500-removed-3','SP500-removed-4','SP500-removed-5','SP500-removed-6'};



for i=1:length(symbols)
    path = ['/Users/b3rnoulli/Development/Matlab workspace/financial-analysis/empirical data/',symbols{i},'/spectrum/window/'];
    files = dir(path);
    
    for j=1:length(files)
        if startsWith(files(j).name, 'SP500-removed-spectrum')
            new_file_name = strrep(files(j).name,'SP500-removed-spectrum',[symbols{i},'-spectrum']);
             movefile([path,files(j).name], [path,new_file_name]);
%             movefile(files(j).name, strrep(files(j).name,))
        end
        
    end
    
    
end