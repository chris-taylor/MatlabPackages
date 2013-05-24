function n = daysInMonth(m, y)
%DAYSINMONTH How many days are in month M in year Y (defaults to current
%year)?
if nargin < 2
    y = datetime.currentYear;
end
n = eomday(y,m);