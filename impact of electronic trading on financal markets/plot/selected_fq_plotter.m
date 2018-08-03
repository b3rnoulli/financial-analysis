clear
clc
indicies = {
    '9-companies', datetime('08-Jan-1965'), datetime('04-Dec-1984');
    '9-companies', datetime('24-Sep-1968'), datetime('27-Jul-1988');
    '9-companies', datetime('30-May-1974'), datetime('08-Mar-1994');
    '9-companies', datetime('22-Jan-1981'), datetime('20-Nov-2000');
    '9-companies', datetime('19-Dec-1988'), datetime('17-Nov-2008');
    '9-companies', datetime('15-Oct-1993'), datetime('30-Sep-2013');
    };
write_to_file=true;
for i=1:1:length(indicies)
    
    f = figure;
    data = load(['/Users/b3rnoulli/Development/Matlab workspace/financial-analysis/empirical data/',...
        indicies{i,1},'/spectrum/window/',indicies{i,1},'-spectrum-',...
        datestr(indicies{i,2},'yyyy-mm-dd'),'-',datestr(indicies{i,3},'yyyy-mm-dd'),'.mat']);

    fq_plotter(f, data.MFDFA2.Scale(1:end), data.MFDFA2.Fq(1:end,31:70), '-k', ...
        [indicies{i,1},'-',datestr(indicies{i,2},'yyyy-mm-dd'),'-',datestr(indicies{i,3},'yyyy-mm-dd')])

    print(f,[indicies{i,1},'-fq-',num2str(i)],'-dpng')

    if write_to_file == true
               fid = fopen([indicies{i,1},'-fq-',num2str(i),'.dat'], 'w') ;
        fprintf(fid,['scale,']);
        for index=1:40
            fprintf(fid,['f_q,']);
        end
        fprintf(fid,['f_q\n']);
        fclose(fid);
        dlmwrite([indicies{i,1},'-fq-',num2str(i),'.dat'],...
        [data.MFDFA2.Scale(1:end)', data.MFDFA2.Fq(1:end,31:70)],'-append');
    end
end
