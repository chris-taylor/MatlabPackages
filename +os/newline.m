function newline = newline
% NEWLINE Returns the newline character, which is \r\n on Windows and \n on Mac OSX/Unix.
if ispc
    newline = char([13, 10]);
elseif ismac
    newline = char(10);
else
    error('os:newline','Unknown system type')
end