function index = naive_search(s, sub)

n = length(s);
m = length(sub);

index = -1; % failure value

for i = 1:n-m+1
    done = true;
    for j = 1:m
        if s(i+j-1) ~= sub(j)
            done = false;
            break
        end
    end
    if done
        index = i;
        break
    end
end