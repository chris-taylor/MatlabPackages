function result = joinWith(thing, varargin)
%JOINWITH
%
%USAGE
%   Join a cell string with the string 'string'
%   >> str.joinWith(string, cellstr);
%
%   Join multiple strings with the string 'string':
%   >> str.joinWith(string, 'Multiple', 'strings', 'here');
%

% Special case when length of varargs is 1
if length(varargin) == 1
    if iscell(varargin{1})
        args = varargin{1};
    else
        args = varargin;
    end
else
    args = varargin;
end

% Loop to join strings
result = args{1};
for ii = 2:length(args)
    result = [result, thing, args{ii}]; %#ok<AGROW>
end