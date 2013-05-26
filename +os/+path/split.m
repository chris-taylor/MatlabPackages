function res = split(path)
% SPLIT Splits the path on file separators, returning a cell array of path
% components.

res = str.split(path, '[\\/]');