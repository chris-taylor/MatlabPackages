function it = fromArray(arr)
% FROMARRAY Returns an iterator that iterates over the columns of ARR.
it = iterator.ArrayIterator.getInstance(arr);