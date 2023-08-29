function SaveFigs(path, ext, varargin)

try
    if ~varargin{1}
        fprintf('Saving Figures...\n')
    end
catch
    fprintf('Saving Figures...\n')
end

FolderName = path;   % Your destination folder
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
parfor_progress(length(FigList));
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  FigName   = get(FigHandle, 'Name');
  saveas(FigHandle, [FolderName, filesep, FigName, '.', ext]);
%   fprintf(['Saving ', FigName, '.', ext, ' to ', path, '\n'])
  parfor_progress();
end
% fprintf('\n')
parfor_progress(0);
end