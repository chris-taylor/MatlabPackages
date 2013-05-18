function r = expandtabs(s,tabsize)
%EXPANDTABS Expand tabs in a string replacing them by one or more spaces,
%depending on the current column and the given tab size. The column number
%is reset to zero after each newline occurring in the string. This doesn?t
%understand other non-printing characters or escape sequences. The tab
%size defaults to 8.

if nargin < 2
    tabsize = 8;
end

n = 1; % counter for place in the output string
c = 1; % column number
r = char(zeros(size(s)));

tab     = char(9);
newline = char(10);
creturn = char(13);

for i = 1:length(s)
    
    switch s(i)
        case tab
            k = tabsize - mod(c-1, tabsize);
            r(n:n+k-1) = ' ';
            c = c + k;
            n = n + k;
        case newline
            r(n) = s(i);
            c = 1;
            n = n + 1;
        otherwise
            r(n) = s(i);
            c = c + 1;
            n = n + 1;
    end
    
end
           
            
            
    