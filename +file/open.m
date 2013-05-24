function f = open(filename, permission)
% OPEN Open a file, returning an object of class file.File. If the file cannot be opened an
% exception is raised.
%
% The arguments are the same as those for the MATLAB function fopen().
%

if nargin == 1
    f = file.File.open(filename);
else
    f = file.File.open(filename, permission);
end