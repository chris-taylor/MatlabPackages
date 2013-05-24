function it = fromCell(arr)
% FROMCELL Returns an iterator that iterates over the elements of the cell
% array ARR.
it = iterator.CellIterator.getInstance(arr);