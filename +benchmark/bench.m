function info = bench(computation, nSamples, verbosity, doplot)
% BENCH Benchmarks a computation.
%
% INPUTS
%   computation     A function handle with zero arguments.
%   nSamples        Number of samples (defaults to 100)
%   verbosity       Verbosity = 0, 1 or 2 (defaults to 2)
%   doPlot          Boolean indicating whether to plot figures or not
%
% OUTPUT
%   info            Struct containing information about the benchmark.
%

    if nargin < 2
        nSamples = 100;
    end
    if nargin < 3
        verbosity = 2;
    end
    if nargin < 4
        doplot = nargout == 0;
    end

    % Check inputs
    if ~isa(computation, 'function_handle')
        error('benchmark:bench:NotAFunctionHandle','First input must be a function handle')
    end
    if ~isscalar(nSamples)
        error('benchmark:bench:NotAScalar','nSamples must be scalar')
    end
    if ~isnumeric(nSamples)
        error('benchmark:bench:NonNumeric','nSamples must be numeric')
    end
    if nSamples <= 0
        error('benchmark:bench:NonPositive','nSamples must be positive')
    end
    if ~isscalar(verbosity)
        error('benchmark:bench:NotAScalar','VERBOSITY must be a scalar')
    end
    if ~isscalar(doplot)
        error('benchmark:bench:NotAScalar','DOPLOT must be scalar')
    end

    % Estimate clock resolution
    fprintf('Estimating clock resolution:     ')
    clock_resolution = benchmark.clockResolution(200000);
    fprintf('%.2f microseconds\n', clock_resolution * 1e6);

    % Estimate cost of a clock call
    fprintf('Estimating cost of a clock call: ')
    cost_of_clock_call = benchmark.costOfClockCall(200000, 1);
    fprintf('%.2f microseconds\n', cost_of_clock_call * 1e6);

    % Estimate how long each repetition will take
    nTest = 20;
    tTest = zeros(1,nTest);
    for i = 1:nTest
        tic;
        computation();
        tTest(i) = toc;
    end

    meanTime = mean(tTest(6:end)) - cost_of_clock_call;
    nIters = ceil(1000 * cost_of_clock_call / meanTime);

    % Benchmark
    nWarmup = 20;
    tSample = zeros(1,nSamples+nWarmup);

    fprintf('Sampling %d times with %d iterations/sample (estimated time: %.2f seconds)\n', ...
        nSamples, nIters, (nSamples+nWarmup) * nIters * meanTime)

    for i = 1:nSamples+nWarmup
        tic;
        for j = 1:nIters
            computation();
        end
        tSample(i) = toc;
    end

    tSample = tSample - cost_of_clock_call;
    tSample = tSample / nIters;

    meanTime = mean(tSample(nWarmup+1:end));
    stdTime  = std(tSample(nWarmup+1:end));

    [tScalar, tUnit] = timeUnit(meanTime);

    fprintf('Boostrapping with 10000 resamples...\n')

    bootResults = bootstrp(10000, @(arr) [mean(arr),std(arr)], tSample(nWarmup+1:end));
    bootQuantile = quantile(bootResults, [0.025, 0.975]);

    meanTimeCi = bootQuantile(:,1);
    stdTimeCi = bootQuantile(:,2);

    fprintf('     Mean: %6.2f %s, lower ci %6.2f, upper ci %6.2f\n', tScalar*meanTime, tUnit, tScalar*meanTimeCi);
    fprintf('  Std dev: %6.2f %s, lower ci %6.2f, upper ci %6.2f\n', tScalar*stdTime, tUnit, tScalar*stdTimeCi);

    % Output
    if nargout > 0
        info.clock_resolution = clock_resolution;
        info.cost_of_clock_call = cost_of_clock_call;
        info.number_of_samples = nSamples;
        info.iterations_per_sample = nIters;
        info.mean_time = meanTime;
        info.stdev_time = stdTime;
        info.ci_mean = meanTimeCi;
        info.ci_stdev = stdTimeCi;
        info.samples = tSample;
    end

    % Plots
    if doplot
        subplot(2, 1, 1)
        bar(tScalar * tSample(nWarmup+1:end));
        xlim([0, 101])
        xlabel('Sample number')
        ylabel(sprintf('Time (%s)', tUnit));

        subplot(2, 1, 2)
        [dens, xs] = ksdensity(tScalar * tSample(nWarmup+1:end));
        plot(xs, dens, 'LineWidth', 2)
        xlabel(sprintf('Time (%s)', tUnit))
        ylabel('Density')
    end


function [scalar, unit] = timeUnit(x)

    if x < 1e-6
        scalar = 1e9;
        unit = 'nanoseconds';
    elseif x < 1e-3
        scalar = 1e6;
        unit = 'microseconds';
    elseif x < 1
        scalar = 1e3;
        unit = 'milliseconds';
    else
        scalar = 1;
        unit = 'seconds';
    end
    

    

