function time = getmtime(path)
% GETMTIME Return the time of last modification of PATH. The return value
% is a MATLAB datenum. Raises an error if the file does not exist or is
% inacessible.

if exist(path,'file')
    info = dir(path);
    if isempty(info)
        error('os:path:getmtime:FileNotAccessible','File not accessible')
    else
        time = info.datenum;
    end
else
    error('os:path:getmtime:FileDoesNotExist','File does not exist')
end
