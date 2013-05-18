function chars = whitespace()
%WHITESPACE The string containing all characters that are considered
%whitespace, i.e. space, newline, carriage return, tab, vertical tab and
%formfeed.
chars = char([32, 10, 13, 9, 11, 12]);