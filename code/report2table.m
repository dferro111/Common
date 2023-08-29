function report2table(rp, rf, sl, varargin)
% Inputs
%   rp - path to report
%   rf - report filename
%   sl - location to save table
%   varargin - Header, value pairs to find
    
if ~contains(rf, '.txt')
    rf = [rf, '.txt'];
end

% Open fresh file
fid = fopen([sl, filesep, 'table_', rf], 'w');

% Prep table
fprintf(fid, '\\begin{table}[H]\n\\centering\n');
fprintf(fid, ['\\caption{GMAT Data}\n']);
fprintf(fid, ['\\label{table:',rf(1:end-4),'}\n']);
fprintf(fid, '\\begin{tabular}{l r r}\n\\hline\\hline\n');
fprintf(fid, '\\textbf{Variable} & \\textbf{Value} & \\textbf{Units} \\\\ \\hline\n');

rep = fopen([rp, filesep, rf], 'r');
% Get Headers
tline = fgetl(rep);
headers = regexpi(tline, '\s*', 'split');


nn = 0;
if isempty(varargin)
    % Get last line of data
    tline2 = 'yes';
    while ischar(tline2)
        line = tline2;
        tline2 = fgetl(rep);
    end
elseif ~mod(length(varargin), 3)
    for ii = 1:3:length(varargin)
        hdidx(nn+1) = find(contains(headers, varargin{ii}));
        if hdidx(nn+1)
            nn = nn + 1;
            lookfor(nn) = varargin(ii);
            value(nn) = varargin(ii+1);
            inunits(nn) = varargin(ii+2);
        else
            error('Invalid input argument type')
        end
    end
else
    error('Additional inputs not in trios')
end

for ii = 1:nn
    % Get last line of data
    tline2 = 'yes';
    while ischar(tline2)
        temp = tline2;
        tempd = regexpi(temp, '\s{4,}', 'split');
        if ~strcmp(temp,'yes') && any(contains(tempd(hdidx(ii)), value{ii})) 
            line{ii} = temp;
            break
        end
        tline2 = fgetl(rep);
    end
end

for kk = 1:nn
    fprintf(fid, [lookfor{kk}, ' = ',value{kk},' ',...
        inunits{kk},' & & \\\\ \\hline \n']);
   
    % Fileter last line of data
    data = regexpi(line{kk}, '\s{4,}', 'split');

    % Find bad headers and data
    gh = 0; gd = 0;
    for ii = 1:length(headers)
        % Check to make sure the header is not empty
        if size(headers{ii},1) == 0
            badidx(ii) = 1;
        else
            badidx(ii) = 0;
            gh = gh+1;
        end
        if size(data{ii}, 1) == 0
            baddata(ii) = 1;
        else
            baddata(ii) = 0;
            gd = gd+1;
        end
    end
    idxh = (~badidx);
    idxd = (~baddata);

    % Check that good headers are the same length as data
    if gd ~= gh
        fprintf('WARNING: Headers do not match data!\n')
    end

    % Populate table with data from the last line
    os = 0; od = 0;% define offset for bad indices
    for ii = 1:gh
        if ~idxh(ii)
            os = os + 1;
        end
        if ~idxd(ii)
            od = od + 1;
        end

        % Replace bad Characters
        head = strrep(headers{ii+os},'_', '\\_');

        % Add specifics for common headers
        units = '--';
        if regexpi(head, ['\.TA\>|\.FPA\>|\.MA\>|\.EA\>|\.INC\>|',...
                '\.AOP\>|\.RAAN\>|\.TLONG\>|'])
            units = '$\\degree$';
        elseif regexpi(head, '\.RMAG\>|\.X\>|\.Y\>|\.Z\>|.SMA\>')
            units = 'km';
        elseif regexpi(head, '\.VMAG\>|\.VX\>|\.VY\>|\.VZ\>')
            units = 'km/s';
        elseif regexpi(head, 'Secs\>')
            units = 's';
        elseif regexpi(head, 'Energy\>')
            units = 'km$^2$/s$^2$';
        end

        if ~contains(head, 'UTC')
            d = double(string(data{ii+od}));
            fprintf(fid, [head, ' & %0.6f',' & ', units,' \\\\\n'], d);
        else
            d = data{ii+od};
            fprintf(fid, [head, ' & ',d, '& ', units,' \\\\\n']);
        end


    end
end
% Close off table
fprintf(fid, '\\hline\\hline\n\\end{tabular}\n\\end{table}');

fclose('all');