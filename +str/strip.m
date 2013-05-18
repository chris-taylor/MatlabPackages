function s = strip(s, chars)
% STRIP Return a copy of the string with leading and trailing characters
% removed. If chars is omitted, whitespace characters are removed. If
% given, chars must be a string; the characters in the string will be
% stripped from the beginning and end of the string this method is called on.

if nargin < 2
    chars = str.whitespace;
end

len = length(s);
loc = false(size(s));

i = 1;
while ismember(s(i), chars)
    loc(i) = true;
    i = i + 1;
end

i   = len;
while ismember(s(i), chars)
    loc(i) = true;
    i = i - 1;
end

s(loc) = [];