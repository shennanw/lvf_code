function [DBfinal] = spikes_measurements_b( unit_number, cluster_class, spikes, DBfinal)

unit = unique(cluster_class(:,1));
if unit(1)==0
    unit = unit(2:end);
end
for k = 1 % we have just one unit in each round
    unit_index = find(cluster_class(:,1) == unit(k));
    unwanted_ind = setdiff((1:size(cluster_class,1)), unit_index);% remove the other units from cluster_class
    if ~isempty(unwanted_ind)
        search_spike_unit= setdiff((1:size(cluster_class,1)), unwanted_ind);%The indices which we will go through
        for i = 1:length(search_spike_unit)
            spikes_mat{k}(i,:) = spikes(search_spike_unit(i),:);
        end
    end
end

for k = 1
    for j = 1: size(spikes_mat{k},1)
        c(k,j) = spikes_mat{k}(j,20);
        ind_trough = 20;
        [p, l, w]= findpeaks(spikes_mat{k}(j,:));
        T{k,j} = [p;l;w];
        [~, ind] = min(abs(T{k,j}(2,:) - ind_trough));
        ind1 = abs(l(ind) - ind_trough); 
        
        if (ind==1)
                loc_a(k,j)= l(ind);
                loc_b(k,j)= l(ind+1);
        
        elseif (ind1<=3 && l(ind)<ind_trough)
                loc_a(k,j) = l(ind-1);
                loc_b(k,j) = l(ind+1);
        
        elseif (ind1<=3 && l(ind)>ind_trough)
                loc_a(k,j) = l(ind-1);
                loc_b(k,j) = l(ind);
        
         elseif (ind1>= 3 && l(ind)>ind_trough)
                 loc_a(k,j) = l(ind-1);
                 loc_b(k,j) = l(ind);
        
        else %(ind>= 3 && l(ind)<ind_trough)
                loc_a(k,j) = l(ind);
                loc_b(k,j) = l(ind+1);
        end
            a(k,j) = spikes_mat{k}(j,loc_a(k,j));
            b(k,j) = spikes_mat{k}(j,loc_b(k,j));
            [p1, loc1, w1] = findpeaks(abs(spikes_mat{k}(j, 1:ind_trough +3)));
            
            indextrough_reversed = find(loc1 ==ind_trough);
            
            if isempty(indextrough_reversed)
                [~,indextrough_reversed] = min(abs(loc1- ind_trough));
            end
            index_trough_reversed = loc1(indextrough_reversed);
            w_p(k,j) = w1(find(loc1==index_trough_reversed));
            
            peak2trough_loc(k,j) = abs(ind_trough - loc_b(k,j));
            peak_amplitude_asymmetry(k,j) = ((b(k,j) - a(k,j))/(a(k,j)+ b(k,j)));
            
     end
 end
    mean_peak_amplitude_asymmetry = mean(peak_amplitude_asymmetry(k,:));
    mean_peak2trough_loc = mean(peak2trough_loc(k,:));
    mean_w_p = mean(w_p(k,:));
    mean_spike = mean (spikes_mat{k});
    DBfinal.peak_amplitude_asymmetry{unit_number} = mean_peak_amplitude_asymmetry;
    DBfinal.peak2trough_loc{unit_number} = mean_peak2trough_loc;
    DBfinal.halfwidth{unit_number} = mean_w_p;
    DBfinal.spike_mean{unit_number} = mean_spike;
end