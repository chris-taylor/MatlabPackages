function out = map(fun, in, type)
% MAP Return a sequence consisting of the input IN, where every element
% has the function FUN applied to it.
%
% The argument OUTPUT determines what the output type is:
%   'array'     Return an array (requires scalar outputs of FUN)
%   'cell'      Return a cell array
%   'default'   Return an array if FUN has scalar outputs, else a cell array.
%

if nargin < 3
    type = 'default';
end

type = lower(type);

if ~ismember(type, {'cell', 'array', 'default'})
    error('fp:map:InvalidInput','TYPE must be CELL, ARRAY or DEFAULT')
end

switch class(in)
    
    case 'cell'
        
        if strcmp(type, 'cell')
            out = cellfun(fun, in, 'uniformoutput', false);
        elseif strcmp(type, 'array')
            out = cellfun(fun, in, 'uniformoutput', true);
        elseif strcmp(type, 'default')
            try
                out = cellfun(fun, in, 'uniformoutput', true);
            catch %#ok
                out = cellfun(fun, in, 'uniformoutput', false);
            end
        end
        
        done = true;
        
    case {'double','single','int8','int16','int32','int64',...
            'uint8','uint16','uint32','uint64','char','logical'}
        
        if strcmp(type, 'cell')
            out = arrayfun(fun, in, 'uniformoutput', false);
        elseif strcmp(type, 'array')
            out = arrayfun(fun, in, 'uniformoutput', true);
        elseif strcmp(type, 'default')
            try
                out = arrayfun(fun, in, 'uniformoutput', true);
            catch %#ok
                out = arrayfun(fun, in, 'uniformoutput', false);
            end
        end
        
        done = true;
        
    otherwise
        
        done = false;
        
end

if ~done
    
    % If the input is not an array or a cell array, then check if it is a
    % Container. If so, we can use the Container 'map' method to apply the
    % function to every element of the container. This modifies the
    % elements in place! If an output is requested from FP.MAP then it will
    % be a handle pointing to the same object as the input, so changes to
    % one of them will affect the other.
   
    if isa(in, 'containers.Container')
       in.map(fun);
    end
    
    if nargout > 0
        out = in;
    end
    
    done = true;
    
end

if ~done
   
    % If the input isn't an array, cell array or a subclass of
    % containers.Container, then we don't know what we can do with it. In
    % the future it would be good to be able to iterate over any object
    % that has subsref and subsasgn methods, but we need to work out how to
    % do that first.
    
    error('fp:map:InvalidInput', 'Invalid input type: %s', class(in))
    
end


        