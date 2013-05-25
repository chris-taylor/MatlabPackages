function sz = getsize(filename)
% GETSIZE Returns the size of a file in bytes. Throws an error if the file
% does not exist or is not accessible.

if exist(filename,'file')
    info = dir(filename);
    if isempty(info)
        error('os:path:getsize:FileNotAccessible','File not accessible')
    else
        sz = info.bytes;
    end
else
    error('os:path:getsize:FileDoesNotExist','File does not exist')
end
