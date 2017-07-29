% Counting number of spikes from LVF onset till the end of LVF
% Reading data ftom raster in data base and does not consider long units

function num_spikes = LVF_num_spike(DBfinal)
chan_num = DBfinal.chan_num;
for  k = 1:length(cell2mat(DBfinal.long_unit))
if DBfinal.long_unit{k} ==1
chan_num{k} =[];
end
end
chan_num_notempty= chan_num(~cellfun('isempty', chan_num));
for i = 1:length(cell2mat(chan_num_notempty))
LVF_start = DBfinal.T_LVF{chan_num_notempty(i)}(1);
LVF_end = DBfinal.T_LVF{chan_num_notempty(i)}(2);

num_spikes(i) = numel(find(DBfinal.Raster{i}(LVF_start*10000:LVF_end* 10000)));
end
end

