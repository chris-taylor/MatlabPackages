function [drive, tail] = splitdrive(path)
% SPLITDRIVE Split the pathname PATH into a pair (DRIVE, TAIL) where DRIVE
% is either a drive specification or the empty string.

if ismac || isunix
    drive = '';
    tail  = path;
    return
end

tokens = regexp(path, '(\w:[\\/])?(.*)', 'tokens');

drive = tokens{1}{1};
tail  = tokens{1}{2};
