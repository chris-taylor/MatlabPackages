function filledText = fill(text, varargin)
% FILL Wraps the single paragraph in TEXT, and returns a single string containing the wrapped
% paragraph. FILL() is shorthand for
%
%   >> str.joinWith(sprintf('\n'), textwrap.wrap(text))
%
% and as such it accepts exactly the same keyword arguments as WRAP().
%

filledText = str.joinWith(char(10), textwrap.wrap(text, varargin{:}));