function wrappedText = wrap(text, varargin)
% WRAP Wraps a single paragraph in TEXT (a char array) so every line is at most WIDTH characters
% long. Returns a cell array of output lines, without final newlines. If the wrapped output has no
% content, the returned cell array is empty.
% 
% INPUTS
%   text    The text to be wrapped
%
% OPTIONAL INPUTS
%   width               Maximum length of wrapped lines.
%   expandTabs          Expand all tab characters to spaces using str.expandtabs
%   replaceWhitespace   Replace \t\n\v\f\r with a single space (after tab expanding, before wrapping)
%   dropWhitespace      Drop initial and final whitespace from each line (after wrapping but before indenting)
%   initialIndent       String prepended to first line of wrapped output.
%   subsequentIndent    String prepended to every subsequent line of wrapped output.
%   breakOnHyphens      If true, spaces and hyphens are valid breakpoints. If false, only spaces.
%

opts = parseInputs(varargin);

if opts.expandTabs
    text = str.expandtabs(text, 4);
end

if opts.replaceWhitespace
    text = regexprep(text, '[\t\n\v\f\r]', ' ');
end

if opts.breakOnHyphens
    breakPoints = find(text == ' ' | text == '-');
else
    breakPoints = find(text == ' ');
end

wrappedText = {};

wrappedLength = 0;
totalLength   = length(text);
numLines      = 0;
prevBrkPoint  = 0;

szInitialIndent = length(opts.initialIndent);
szSubsqntIndent = length(opts.subsequentIndent);

while wrappedLength < totalLength
   
    if numLines == 0 % initial line
        nextBrkPoint = breakPoints(find(breakPoints > wrappedLength + opts.width - szInitialIndent, 1, 'first') - 1);
    else             % subsequent lines
        nextBrkPoint = breakPoints(find(breakPoints > wrappedLength + opts.width - szSubsqntIndent, 1, 'first') - 1);
    end
    
    if isempty(nextBrkPoint)
        nextBrkPoint = totalLength;
    end
    
    wrappedText{numLines + 1} = text(prevBrkPoint+1:nextBrkPoint); %#ok<AGROW>
    
    numLines      = numLines + 1;
    wrappedLength = wrappedLength + nextBrkPoint - prevBrkPoint;
    prevBrkPoint  = nextBrkPoint;
    
    % Drop whitespace
    if opts.dropWhitespace
        wrappedText{numLines} = strtrim(wrappedText{numLines}); %#ok<AGROW>
    end
    
    % Indent
    if numLines == 1
        wrappedText{numLines} = [opts.initialIndent, wrappedText{numLines}]; %#ok<AGROW>
    else
        wrappedText{numLines} = [opts.subsequentIndent, wrappedText{numLines}]; %#ok<AGROW>
    end
      
end


function opts = parseInputs(args)
p = inputParser;
p.addParamValue('width', 70, @(arg) isnumeric(arg) && isscalar(arg));
p.addParamValue('expandTabs', true, @isbool);
p.addParamValue('replaceWhitespace', true, @isbool);
p.addParamValue('dropWhitespace', true, @isbool);
p.addParamValue('initialIndent', '', @ischar);
p.addParamValue('subsequentIndent', '', @ischar);
p.addParamValue('breakOnHyphens', true, @isbool)
p.parse(args{:});
opts = p.Results;

function res = isbool(arg)
res = islogical(arg) && isscalar(arg);