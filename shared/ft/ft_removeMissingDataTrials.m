function data = ft_removeMissingDataTrials(cfg_in,data)
% data = ft_removeMissingDataTrials(cfg_in,data)

cfg_def = [];

cfg = ProcessConfig(cfg_def,cfg_in);

for iT = 1:length(data.trial)
    
    this_data = data.trial{iT};
    if any(isnan(this_data(:)))
        keep(iT) = false;
    else
        keep(iT) = true;
    end
 
end

data.time = data.time(keep);
data.trial = data.trial(keep);
data.sampleinfo = data.sampleinfo(keep,:);