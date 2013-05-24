function res = isIterable(obj)
% ISITERABLE Returns true if OBJ is iterable (i.e. supports next() and hasNext() methods) and false
% otherwise.
res = ismethod(obj,'next') && ismethod(obj,'hasNext');