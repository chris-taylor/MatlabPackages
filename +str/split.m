function cellstr = split(str, substr)
%SPLIT
%
%USAGE
%   Split the string 'str' on whitespace:
%   >> cellstr = str.split(str)
%
%   Split the string 'str' on the regular expression 'substr'
%   >> cellstr = str.split(str, substr)
%
if nargin < 2
    substr = '\s+';
end

cellstr = regexp(str, substr, 'split');

% Need to remove empty strings
rem = cellfun(@isempty, cellstr);
cellstr(rem) = [];
