function home = homedir()
% HOMEDIR Return the user's home directory.
if ispc
    home = [getenv('HOMEDRIVE') getenv('HOMEPATH')];
else
    home = getenv('HOME');
end