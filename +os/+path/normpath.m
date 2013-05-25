function path = normpath(path)
% NORMPATH Normalize a path name by collapsing redundant separators and
% up-level references, so that A//B, A/B/, A/./B and A/foo/../B all become
% A/B. On Windows it converts forward slashes to back slashes. To normalize
% case, use normcase().

parts = str.split(path, '[\\/]');

k = 1;
n = length(parts);

while k <= n
    if strcmp(parts{k}, '.')
        parts(k) = [];
        n = n - 1;
    elseif strcmp(parts{k}, '..')
        parts(k-1:k) = [];
        n = n - 2;
    else
        k = k + 1;
    end
end

path = fullfile(parts{:});