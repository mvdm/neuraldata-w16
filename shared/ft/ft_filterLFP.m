function data = ft_filterLFP(data,f,varargin)
% function data = ft_filterLFP(data,f,varargin)
%
% f should be specified as passband, e.g [1 150]
%
% varargins with defaults:
% ford = 6;
% fmode = 'bandpass'; % 'high', 'low'

ford = 6;
fmode = 'bandpass';
Fs = data.hdr.Fs;

% build filter
Wp = f * 2 / Fs; % pass band for filtering
switch fmode
    case 'bandpass'
        [B,A] = butter(ford,Wp); % builds filter
    case 'highpass'
        [B,A] = butter(ford,Wp(1),'high'); % builds filter
    case 'lowpass'
        [B,A] = butter(ford,Wp(1),'low'); % builds filter
    otherwise
        error('Unknown fmode.');
end

extract_varargin;

% filter
for iS = 1:length(data.trial)
    
    % first check for nans
    d = data.trial{iS};
    
    nan_idx = [];
    if any(isnan(d))
        fprintf('WARNING (ft_filterLFP.m): trial %d has NaNs.\n',iS);
        
        nan_idx = find(isnan(d));
        d(nan_idx) = 0;
        
    end
    
    d = filtfilt(B, A, d); % runs filter
    d(nan_idx) = NaN;
    
   data.trial{iS} = d;
   
end

