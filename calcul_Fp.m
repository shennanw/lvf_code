function [fp_mat, unit_spikes] = calcul_Fp(cluster_class,spikes, end_time, Tau_r, Tau_c)

unit_num = unique(cluster_class(:,1));

N = size(spikes, 1); % total number of spikes
unit_spikes = zeros(numel(unit_num),end_time* 10000);
ISI_unit =  zeros(numel(unit_num),end_time* 10000);
for i=1:length(cluster_class(:,1))
    for j = 1: length(unit_num)
    if cluster_class(i,1)==unit_num(j)
        unit_spikes(unit_num(j) + 1,round(cluster_class(i,2)*10))=1;
    end;
    end
    
end
% For each unit we calculate the ISI 
for unit = 1: size(unit_spikes,1)
x = unit_spikes(unit,:);
x_le = length(x);
i = 1;
while ( x(1,i)==0 & i<x_le)
  i = i + 1;
end;
first_spike = i;
i = i + 1;

%computes the isi 
while ( i < x_le )
  if ( x(1,i)==1 )
    isi = i - first_spike;
    first_spike = i;
    ISI_unit(unit, i)=isi; 
  end;
  i = i + 1;
end;
 ISI_unit_cell{unit} = ISI_unit(unit,:);
 ISI_spike{unit} = ISI_unit_cell{unit}(ISI_unit_cell{unit}~=0);
 
 b{unit}= find(ISI_spike{unit}<10);

 
 r{unit} = numel(b{unit}); % Number of refracory period

fp{unit} = 1- (sqrt(1-4*(r{unit}* (end_time)/(2* (Tau_r-Tau_c)* N^2)))); % False positive
%fp = find(cell2mat(fp)==0);
end

fp_mat = cell2mat(fp);
if unit_num(1)==0
    fp_mat = fp_mat(2:end);
end