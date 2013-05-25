function res = exists(path)
% EXISTS Return true if PATH refers to an existing path.
if exist(path,'dir') || exist(path,'file')
    res = true;
else
    res = false;
end