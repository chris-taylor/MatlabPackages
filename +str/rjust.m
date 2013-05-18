function s = rjust(s, width, fillchar)
% LJUST Left-justify a string. This function returns a string that is at
% least 'width' characters wide, created by padding the string 's' with the
% character 'fillchar' (default is a space) until the given width on the
% right. The string is never truncated.

if nargin < 3
    fillchar = ' ';
end

f = str.internal.vectorize(@impl);
s = f(s, width, fillchar);

function impl(s, width, fillchar)

len = length(s);

if len > width
    return
end

s = [repmat(fillchar, 1, width-len), s];