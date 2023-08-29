function make_2col_table(cap, lbl, c1t, c2t, d1, d2)
% Generate a 2 column table in Latex formatting
% 
% Inputs:
%   cap - table caption, string
%   lbl - label for table, string
%   c1t - title of first column, string
%   c2t - title of second column, string
%   d1 - data for first column, cell array
%   d1 - data for second column, string array

filename = regexpi(lbl, ':\w*','match');
f = fopen(['../tables/',filename{1}(2:end),'.txt'],'w');

fprintf(f, '\\begin{table}[H]\n');
fprintf(f, ['\\centering\n\\caption{', cap, '}\n']);
fprintf(f, ['\\label{', lbl, '}\n']);
fprintf(f, '\\begin{tabular}{l r}\n\\hline\\hline\n');
fprintf(f, ['\\textbf{',c1t,'} & \\textbf{',c2t,'}\\\\ \\hline\n']);
for ii = 1:length(d1)
    fprintf(f, [d1{ii}, ' & $', d2(:,:,ii), '$ \\\\ \n']);
end
fprintf(f, '\\hline\\hline\n');
fprintf(f, '\\end{tabular}\n\\end{table}');
fclose(f);


end