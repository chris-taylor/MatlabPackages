function vf = vectorize(f,n)
% VECTORIZE Automatic vectorization of functions. This takes any function
% that operates on a character vector, and lifts it to a function that
% operates on both character vectors and cell arrays. If the function
% outputs a scalar, the vectorized function will output an array. Otherwise
% the vectorized function will output a cell array containing the results.
% The argument 'n' (defaults to 1) indicates which of the arguments of 'f'
% is to be vectorized.

    if nargin < 2
        n = 1;
    end

    function result = vectorized_function(varargin)
        arg_head = varargin{n};
        arg_rest = varargin; arg_rest(n) = [];
        if isa(arg_head, 'cell')
            try
                result = cellfun(@(x) f(x,arg_rest{:}), arg_head);
            catch err
                if strcmp(err.identifier, 'MATLAB:cellfun:NotAScalarOutput')
                    result = cellfun(@(x) f(x,arg_rest{:}), arg_head, 'UniformOutput', false);
                else
                    rethrow(err);
                end
            end
        else
            result = f(arg_head, arg_rest{:});
        end
    end

    vf = @vectorized_function;

end