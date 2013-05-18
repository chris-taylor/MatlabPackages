function s = center(s, width, fillchar)
% LJUST Left-justify a string. This function returns a string that is at
% least 'width' characters wide, created by padding the string 's' with the
% character 'fillchar' (default is a space) until the given width on the
% right. The string is never truncated.

if nargin < 3
    fillchar = ' ';
end

f = str.internal.vectorize(@impl);
s = f(s, width, fillchar);

function s = impl(s, width, fillchar)

len = length(s);

if len > width
    return
end

n = width-len;

if mod(n,2) % odd
    s = [repmat(fillchar, 1, (n-1)/2), s, repmat(fillchar, 1, (n+1)/2)];
else
    s = [repmat(fillchar, 1, n/2), s, repmat(fillchar, 1, n/2)];
end
