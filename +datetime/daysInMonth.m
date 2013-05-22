function n = daysInMonth(m, y)
%DAYSINMONTH How many days are in month M in year Y (defaults to current
%year)?

if nargin < 2
    y = datetime.currentYear;
end

switch m
    case {1, 3, 5, 7, 8, 10, 12}
        n = 31;
    case {4, 6, 9, 11}
        n = 30;
    case 2
        n = 28 + datetime.isLeapYear(y);
    otherwise
        error('datetime:daysInMonth:BadMonth','month must be between 1 and 12')
        
end