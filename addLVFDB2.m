function [db]= addLVFDB2(patient_num, given_unit_number,ch_num, long_unit, cluster_class, spikes, location_code, soz_code, T_raw, fp_mat, unit_spikes,db)
% %%%%%%%%%This program runs for single channel of each patient and for all detected
%%%%%%%%%%% units except the unit zero which is artifact
% - patient_num = Patient's number
% - given_unit_num = the unit number we want to calculate
% - long_unit = is 'yes ' if it is a unit with long spike duration and 'No' otherwise 
% - cluster_class = number of spikes * start time of each [msec]
% - spikes = number of spikes * number of data point for each spike                            
% - T_raw : start and end of LVF [s]; end of LVF is end of the recording
% - unit_spikes: matrix for all units. raws are number of units and column is
% time. This matrix is 1 at the time of spike.
% - Spike_pre: All the spikes happening before the LVF start
% - spikes_post: All the spikes happening after LVF start up to end of
% recording
% - spike_all: All the spikes 
% if exist('db', 'var') == 0
%     db=struct('patient', {}, 'chan_num', {}, 'loc_code', {}, 'SOZ_code', {}, 'long_unit', {}, 'spike_pre', {}, 'spike_post', {}, 'spike_all', {}, 'T_LVF', {}, 'FP', {}, 'Raster', {});
% end
% db.patient = [db.patient, patient_num];
% p = db.patient;
% db.chan_num = [db.chan_num, ch_num];
% db.loc_code = [db.loc_code, location_code];
% db.SOZ_code = [db.SOZ_code, soz_code];
units = unique(cluster_class(:,1));
unit_len = length(units);
start_time = T_raw(1) * 10000; % start time for LVF
end_time = T_raw(2) * 10000; % end of the recroding or end of LVF

if (unit_len>=2 & units(1)==0)
    units = units(2:end);
    unit_spikes = unit_spikes(2:end, :);
end
k =0; % loop counter
    for i =  given_unit_number(1):given_unit_number(end) % i is the current unit number
        k = k+ 1;
        if strcmpi(long_unit(k), 'Yes')
            db.long_unit{1, i} = 1;
        else
            db.long_unit{1, i}= 0;
        end
        db.patient{i} = [patient_num];
        db.chan_num{i} =  [ch_num];
        db.loc_code{i} = [location_code];
        db.SOZ_code{i} =  [soz_code];
        unit_index = find(cluster_class(:,1)== units(k));
        [~,index_LVF_start] = min(abs(cluster_class(:,2)* 10 - start_time));% find the index of the LVF start in cluster_class
              
        [~, index_LVF_end] = min(abs(cluster_class(:,2)* 10 - end_time));
        unwanted_ind = setdiff((1:size(cluster_class, 1)), unit_index);% remove the other units from cluster_class
        if ~isempty(unwanted_ind) % in case we have just one unt which is not artifact
        db.spike_pre {i}= spikes(setdiff((1:index_LVF_start),unwanted_ind),:);% remove all indices which are not in the same unit
        db.spike_post{i} = spikes(setdiff((index_LVF_start:index_LVF_end), unwanted_ind),:);
        else
            db.spike_pre{i}= spikes(1:index_LVF_start,:);
            db.spike_post{i}= spikes(index_LVF_start:index_LVF_end,:);
        end
        
        
        db.spike_all{i}= [db.spike_pre(end); db.spike_post(end)];
        db.T_LVF {i}= T_raw;
        db.FP{i} = fp_mat(k);
        db.Raster{i} = int8(unit_spikes(k,:));
    end


end

