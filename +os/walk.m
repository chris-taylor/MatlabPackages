function visited = walk(top)
% Generate the file names in a directory tree by walking the tree top down. Each directory in the
% tree yields a struct with three fields, 'dirpath', 'dirnames' and 'filenames'.

tovisit = containers.FifoQueue(top);
visited = struct();

cnt = 1;

while tovisit.hasNext
    
    dirpath = tovisit.next;
    
    visited(cnt).dirpath   = dirpath;
    visited(cnt).dirnames  = {};
    visited(cnt).filenames = {};
    
    contents = dir(dirpath);
    
    for ii = 1:length(contents)
        relpath = contents(ii).name;
        abspath = fullfile(dirpath, relpath);
        if exist(abspath, 'dir') && ~strcmp(relpath,'.') && ~strcmp(relpath,'..')
            tovisit.push(abspath);
            visited(cnt).dirnames{end+1} = abspath;
        elseif exist(abspath, 'file')
            visited(cnt).filenames{end+1} = abspath;
        end
    end
    
    cnt = cnt + 1;
    
end