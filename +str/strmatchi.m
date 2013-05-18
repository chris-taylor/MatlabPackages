function loc = strmatchi(str,arr)
%STRMATCHI Case-insensitive strmatch.
str = lower(str);
arr = cellfun(@lower,arr,'uniformoutput',false);
loc = strmatch(str,arr);
end