classdef Date
   
    properties (SetAccess = private)
        year
        month
        day
    end
    
    properties (Access = private)
        dnum
    end
    
    methods
        
        %========================
        % Constructor
        %========================
        
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
        
        %========================
        % Conversion methods
        %========================
        
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
        
        function str = asString(obj)
            str = sprintf('datetime.Date(%d,%d,%d)',obj.year,obj.month,obj.day);
        end
        
        %========================
        % Comparison operators
        %========================
        
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
        
        %========================
        % Arithmetic operators
        %========================
        
        function out = plus(d, in)
            if isa(in,'datetime.TimeDelta')
                % Date plus a TimeDelta is another Date
                out = d.fromDatenum(d.asDatenum + in.delta);
            end
        end
        
        function out = minus(d, in)
            if isa(in,'datetime.Date')
                % Difference of two Dates is a TimeDelta
                out = datetime.TimeDelta.fromDouble(d.asDatenum - in.asDatenum);
            elseif isa(in,'datetime.TimeDelta')
                % Date minus a TimeDelta is another Date
                out = d.fromDatenum(d.asDatenum - in.delta);
            end
        end
        
        %========================
        % Derived methods
        %========================
        
        function w = weekday(obj)
            w = weekday(obj.asDatenum);
        end
        
        function disp(obj)
            disp(obj.asString);
        end
        
    end
    
    methods (Static = true)
        function obj = fromDatenum(dn)
            [y, m, d] = datevec(dn);
            obj = datetime.Date(y,m,d);
        end
    end
    
end