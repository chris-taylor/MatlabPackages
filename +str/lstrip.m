function s = lstrip(s, chars)
% LSTRIP Return a copy of the string with leading characters removed. If
% chars is omitted, whitespace characters are removed. If given, chars must
% be a string; the characters in the string will be stripped from the start
% of the string this method is called on.

if nargin < 2
    chars = str.whitespace;
end

loc = false(size(s));
i   = 1;
while ismember(s(i), chars)
    loc(i) = true;
    i = i + 1;
end

s(loc) = [];