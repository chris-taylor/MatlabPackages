function result = join(varargin)
%JOIN Join multiple strings with spaces.
%
%USAGE
%   Join all the strings in a cell array:
%   >> str.join(cellstr);
%
%   Join multiple strings:
%   >> str.join('Multiple', 'strings', 'here');
%

result = str.joinWith(' ', varargin{:});