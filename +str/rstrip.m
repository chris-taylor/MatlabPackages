function s = rstrip(s, chars)
% RSTRIP Return a copy of the string with trailing characters removed. If
% chars is omitted, whitespace characters are removed. If given, chars must
% be a string; the characters in the string will be stripped from the end
% of the string this method is called on.

if nargin < 2
    chars = str.whitespace;
end

len = length(s);
loc = false(size(s));
i   = len;
while ismember(s(i), chars)
    loc(i) = true;
    i = i - 1;
end

s(loc) = [];