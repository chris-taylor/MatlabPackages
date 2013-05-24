classdef CellIterator < iterator.Iterable
% CELLITERATOR Iterate over the elements of a cell array; first down the
% columns and then across the rows. 

    properties
        arr
        curpos = 1
        sz
    end
    
    methods (Static)
        function it = getInstance(arr)
            if ~isa(arr,'cell')
                error('iterator:CellIterator:NotACell','Argument ARR must be a cell array')
            end
            it = iterator.CellIterator(arr);
        end
    end
    
    methods (Access = public)
        function res = hasNext(it)
            res = not(it.curpos > it.sz);
        end
        
        function e = next(it)
            e = it.arr{it.curpos};
            it.curpos = it.curpos + 1;
        end
    end
    
    methods (Access = private)
        function it = CellIterator(arr)
            it.arr = arr(:);
            it.sz  = numel(it.arr);
        end
    end
end