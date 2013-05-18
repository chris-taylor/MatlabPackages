function hash = hash(str)
%HASH Computes the hash code of a string as an integer
hash = java.lang.String(str).hashCode();