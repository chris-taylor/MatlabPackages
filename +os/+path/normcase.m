function path = normcase(path)
% NORMCASE Normalize the case of a pathname. On Unix and Mac OS X this
% returns the path unchanged. On case insensitive filesystems it converts
% the path to lowercase. On Windows it converts forward slashes to
% backslashes.

if ismac || isunix
    return
end

parts = str.split(path, '[\\/]');
path  = lower(parts{1});

for ii = 2:length(parts)
    path = [path filesep lower(parts{ii})]; %#ok
end