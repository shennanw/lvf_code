function [s, t] = spikeTrainDensity(ts, resolution, sigma, DBfinal)
% [s, t] = spikeTrainDensity(ts, resolution, sigma)
% Returns the spike density function from a spike raster.
%   * ts: spike train (s)
%   * resolution|dt: spike train resolution - binning size (ms)
%   * sigma: confidence interval of the spike times (ms)
% Adapted from Matlab for Neuroscientists.
%



% Use hist to bin
EDGES = (0:resolution:DBfinal.T_LVF{1}(2)*10000);
N = histc(ts, EDGES);
%Time ranges form -3*st. dev. to 3*st. dev.
edges = (-3*sigma:resolution:3*sigma);
%Evaluate the Gaussian kernel
kernel = normpdf(edges,0,sigma);
%Multiply by bin width so the probabilities sum to 1
kernel = kernel.*resolution; 
%Convolve spike data with the kernel
s = conv(N,kernel);
%Find the index of the kernel center
center = ceil(length(edges)/2); 
%Trim out the relevant portion of the spike density
s = s(center:end-center-1); 
t = (0:DBfinal.T_LVF{1}(2)*10000-2);
%if exist('PLOT','var')
    figure;
    plot(t,s,'k')
%     hold on
%    plot(DBfinal.Raster{1})

    %plotRastergram({double(ts)},'color','r')
end