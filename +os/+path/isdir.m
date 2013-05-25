function res = isdir(path)
% ISDIR Return true if path is an existing directory.
res = exist(path,'dir');