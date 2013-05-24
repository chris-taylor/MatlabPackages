classdef ArrayIterator < iterator.Iterable
% ARRAYITERATOR Iterates over the columns of an array.

    properties
        arr
        curpos = 1
        sz
    end
    
    methods (Static)
        function it = getInstance(arr)
            it = iterator.ArrayIterator(arr);
        end
    end
    
    methods (Access = public)
        function res = hasNext(it)
            res = not(it.curpos > it.sz);
        end
        
        function e = next(it)
            e = it.arr(:, it.curpos);
            it.curpos = it.curpos + 1;
        end
    end
    
    methods (Access = private)
        function it = ArrayIterator(arr)
            it.arr = arr;
            it.sz  = size(array,2);
        end
    end
    
end