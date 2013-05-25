function res = isfile(path)
% ISPATH Return true if the path is a file.
res = exist(path,'file');