function res = isabs(path)
% ISABS Return true if PATH is an absolute pathname. On Unix/Mac OS X that
% means it begins with a slash, on Windows it means it begins with a
% backslash after chopping off a potential drive letter.

if isunix
    res = path(1) == '/';
elseif ispc
    res = path(1) == '\' || (isletter(path(1)) && strcmp(path(2:3), ':\'));isli
else
    error('os:path:isabs:Unrecognized operating system');
end