function res = clockResolution(nsamples)
t = zeros(1,nsamples);
for i = 1:nsamples
    tic;
    t(i) = toc();
end
res = min(t(t>0));