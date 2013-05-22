function result = isLeapYear(y)
%ISLEAPYEAR Takes an integer between 0 and 9999 as input, and returns if it
%is a leap year or not.
result = ~mod(y,4) && (mod(y,100) || ~mod(y,400));