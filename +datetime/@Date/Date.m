classdef Date
   
    properties (SetAccess = private)
        year
        month
        day
    end
    
    methods
        function obj = Date(y, m, d)
            if y < datetime.MIN_YEAR || y > datetime.MAX_YEAR
                error('datetime:Date:BadYear', 'Year must be between 0 and 9999')
            end
            if m < 1 || m > 12
                error('datetime:Date:BadMonth', 'Month must be between 1 and 12')
            end
            if d < 1 || d > datetime.daysInMonth(m,y)
                error('datetime:Date:BadMonth', 'Day is invalid for this year/month')
            end
            obj.year = y;
            obj.month = m;
            obj.day = d;
        end
        
        function d = asDatenum(obj)
            d = datenum(obj.year, obj.month, obj.day);
        end
        
        function d = asDatestr(obj,fmt)
            if nargin == 1
                d = datestr(obj.asDatenum);
            else
                d = datestr(obj.asDatenum, fmt);
            end
        end
        
        function [y, m, d] = asDatevec(obj)
            if nargout < 1
                y = [obj.year, obj.month, obj.day];
            else
                y = obj.year;
                m = obj.month;
                d = obj.day;
            end
        end
        
        function w = weekday(obj)
            w = weekday(obj.asDatenum);
        end
        
        function result = lt(d1, d2)
            result = d1.asDatenum < d2.asDatenum;
        end
        
        function result = le(d1, d2)
            result = d1.asDatenum <= d2.asDatenum;
        end
        
        function result = gt(d1, d2)
            result = d1.asDatenum > d2.asDatenum;
        end
        
        function result = ge(d1, d2)
            result = d1.asDatenum >= d2.asDatenum;
        end
        
        function result = eq(d1, d2)
            result = d1.asDatenum == d2.asDatenum;
        end
        
        function d2 = plus(d1, timedelta)
            d2 = timedelta + d1;
        end
        
        function td = minus(d1, d2)
            td = datetime.TimeDelta.fromDouble(d1.asDatenum - d2.asDatenum);
        end
        
        function disp(obj)
            str = sprintf('datetime.Date(%d,%d,%d)',obj.year,obj.month,obj.day);
            disp(str);
        end
    end
    
    methods (Static = true)
        function obj = fromDatenum(dn)
            [y, m, d] = datevec(dn);
            obj = datetime.Date(y,m,d);
        end
    end
    
end