function n = count(s, str)
%COUNT Return the number of (non-overlapping) occurence of substring 'sub'
%in string 's'.

n = length(strfind(s, str));