classdef TimeDelta
   
    properties (SetAccess = private)
        days
        hours
        minutes
        seconds
        milliseconds
        delta
    end
    
    methods
        function td = TimeDelta(varargin)
            % Parse inputs
            inp = datetime.TimeDelta.ParseInputs(varargin);
            
            % Assign fields
            td.days = inp.days;
            td.hours = inp.hours;
            td.minutes = inp.minutes;
            td.seconds = inp.seconds;
            td.milliseconds = inp.milliseconds;
            
            % Compute delta
            td.delta = td.days + td.hours / 24 + td.minutes / (24 * 60) + ...
                td.seconds / (24 * 60 * 60) + td.milliseconds / (24 * 60 * 60 * 1000);
        end
        
        function t2 = plus(td, t1)
            t2 = t1.fromDatenum(t1.asDatenum + td.delta);
        end
        
        function disp(td)
            str = sprintf('datetime.TimeDelta(days=%d,hours=%d,minutes=%d,seconds=%d,milliseconds=%d)',...
                    td.days,td.hours,td.minutes,td.seconds,td.milliseconds);
            disp(str);
        end
    end
    
    methods (Static = true)
        function inp = ParseInputs(args)
            p = inputParser;
            p.addParamValue('days', 0, @isscalar)
            p.addParamValue('hours', 0, @isscalar)
            p.addParamValue('minutes', 0, @isscalar)
            p.addParamValue('seconds', 0, @isscalar)
            p.addParamValue('milliseconds', 0, @isscalar)
            p.parse(args{:})
            inp = p.Results;
        end
        
        function td = fromDouble(x)
            d = floor(x); x = 24 * (x - d);
            h = floor(x); x = 60 * (x - h);
            m = floor(x); x = 60 * (x - m);
            s = floor(x); x = 1000 * (x - s);
            ms = floor(x);
            
            td = datetime.TimeDelta('days',d,'hours',h,'minutes',m,...
                    'seconds',s,'milliseconds',ms);
        end
    end
    
end