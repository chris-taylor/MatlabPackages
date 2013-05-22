function [data, header] = parse(s,varargin)
%CSV.READ Reads CSV file into a cell array (each column gets into a
%separate cell)
% 
%   USAGE:
%       [data, header] = csv.read(fname)
%       [data, header] = csv.read(fname,'bufsize',10000)
%       [data, header] = csv.read(fname,'header',false)
%       [data, header] = csv.read(fname,'format','%s %d %f')
%       [data, header] = csv.read(fname,'header',false,'delim',sprintf('\t'))
% 
%   OUTPUTS:
%       DATA   - (1 x N) cell array, where N - # of columns in a file.
%       HEADER - [OPTIONAL] (1 x N) cell array of headers
%
%   NOTES:
%       Headers cannot contain commas or quotation marks.

% Parse inputs

params = ParseInputs(varargin);

headerLine = params.header;
formatSpec = params.format;
delim      = params.delim;
output     = params.output;
bufsize    = params.bufsize;

% Format specs

newline = char(10);
ii      = regexp(s, newline, 'once');
tline   = s(1:ii-1);
nfields = length(strfind(tline,delim)) + 1;

if isempty(formatSpec)
    formatSpec =  repmat('%q', 1, nfields);
end

% Read file

if headerLine
    theader = textscan(tline, repmat('%s', 1, nfields), 'Delimiter', delim);
    header = cell(1, nfields);
    for i = 1: nfields
        if isempty(theader{i})
            header(i) = '';
        else
            header(i) = theader{i};
        end
    end
    if length(header{1}) >= 3 && length(unicode2native(header{1}(1:3),'UTF-8'))==6 && all(unicode2native(header{1}(1:3),'UTF-8')==[195  175  194  187  194  191])
        header{1}(1:3) = [];
    end
    s(1:ii-1) = [];
else
    fseek(fid, 0, 'bof');
    header = [];
end

data = textscan(s, formatSpec, 'Delimiter', delim, 'bufsize', bufsize);

if strcmp(output,'struct')
    varname = cell(1,nfields);
    for ii = 1:nfields
        varname{ii} = genvarname(header{ii});
    end
    data = cell2struct(data, varname, 2);
end

end

function results = ParseInputs(args)
p = inputParser;
p.addParamValue('header',true,@islogical);
p.addParamValue('format','',@ischar);
p.addParamValue('delim',',',@ischar);
p.addParamValue('bufsize',4095,@isscalar);
p.addParamValue('output','cell',@(arg)ismember(arg,{'cell','struct'}))
p.parse(args{:});
results = p.Results;
end