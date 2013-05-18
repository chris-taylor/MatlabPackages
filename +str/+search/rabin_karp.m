function index = rabin_karp(s, sub)
%RABIN_KARP Performs Rabin-Karp substring search using a rolling hash
%function.

n = length(s);
m = length(sub);

hsub  = hash(sub);
hs    = hash(s(1:m));
index = -1; % failure value

for i = 1:n-m+1
    if i == 3
        keyboard
    end
    if hs == hsub
        if strcmp(s(i:i+m-1), sub)
            index = i;
            break
        end
    end
    if i < n-m+1
        hs = rolling_hash(s(i+1:i+m), s(i:i+m-1), hs);
    end
end

function h = hash(s)
%HASH First iteration of the rolling hash function
h = 0;
p = 101;
for i = 1:length(s)
    h = p * h + int32(s(i));
end

function h = rolling_hash(s, old_s, old_hash)
%HASH Rolling hash function.
m = length(old_s);
p = 101;    
h = p * (old_hash - int32(old_s(1)) * p^(m-1)) + int32(s(end));