% To smoothen the firing rate of spikes, we feed a gaussian function with 100 ms kernel (in data base we have (kernels= 200, 50 ms as well)
% to raster plot and we want to see the how the inhibitory and excitatory neurons are changing in
% term of firing before and after LVF in 3 different rigions separately and just in SOZ

% We calculated the mean and standard error of each rigion to demonstrate
% the shaded error barlength_raster = cellfun('length',DBfinal.Raster);
max_length_raster = max(length_raster);
for i = 1:length(DBfinal.Raster)
DBfinal.Raster{i}(length(DBfinal.Raster{i})+1:max_length_raster)=0;
end

% length_gaussian = cellfun('length',DBfinal.gaussian_100);
% max_length_gaussian = max(length_gaussian);
% for i = 1:length(DBfinal.gaussian_100)
% DBfinal.gaussian_100{i}(length(DBfinal.gaussian_100{i})+1:max_length_gaussian)=0;
% end

%% ALigne all Guassian functions to the start of LVF
for i = 1:113
    shift = DBfinal.T_LVF{i}(1)*10000;
    T_B = 0:max_length_raster-1;
    T_B = T_B - shift;
    ind = find(T_B > -150*10000  & T_B < max_length_raster-shift); 
    gaussian_100_new{i} = DBfinal.gaussian_100{i}(ind);
end

%% From end of LVF to the end of the maximum LVF should be NAN
     for i = 1:113 
        ind_end = find (T_B== (DBfinal.T_LVF{i}(2)* 10000 )+ 150*10000);
        gaussian_100_new{i}(ind_end :end) =NaN;
        if DBfinal.T_LVF{i}(1)* 10000 <150* 10000
            new_vec_100=[nan(1,(150* 10000 - DBfinal.T_LVF{i}(1)* 10000))  gaussian_100_new{i}];%we need to add NaN at the begining of those who has less than 100 sec
           gaussian_100_new{i} = new_vec_100;
            %figure; plot(T_B_new, gaussian_new{i});
        end
     end
     
 length_gaussian_100_new = cellfun('length',gaussian_100_new);
max_length_gaussian_100_new = max(length_gaussian_100_new);
for i = 1:length(length_gaussian_100_new)
gaussian_100_new{i}(length(gaussian_100_new{i})+1:max_length_gaussian_100_new)=NaN;
end    
%% calculate the mean and STD for hippocampus 
Hippo_index = [28:30, 44, 45, 46, 48:56, 62:66  72: 76, 84:91, 112, 113];

for i = 1: length(Hippo_index)
   gaus_hippo_units(i,:) = gaussian_100_new{Hippo_index(i)};
end

inhib_hippo = [   62, 63, 88, 113];% 44
for i = 1: length(inhib_hippo)
   gaus_inhib_hippo_units(i,:) = gaussian_100_new{inhib_hippo(i)};
end
d_in_hippo_mean = nanmean( gaus_inhib_hippo_units);
d_in_hippo_std = nanstd(gaus_inhib_hippo_units);
     figure;plot((1:length(d_in_hippo_mean))/10000,d_in_hippo_mean)
   xlabel('Time [Sec]');
   title ('The mean of Inhibitory units SOZ Hippocampus ')
  
   exc_hippo = setdiff(Hippo_index, inhib_hippo);
for i = 1: length(exc_hippo)
   gaus_exc_hippo_units(i,:) = gaussian_100_new{exc_hippo(i)};
end 
   d_ex_hippo_mean = nanmean( gaus_exc_hippo_units);
   d_ex_hippo_std = nanstd(gaus_exc_hippo_units);
     figure;plot((1:length(d_ex_hippo_mean))/10000,d_ex_hippo_mean)
   xlabel('Time [Sec]');
   title ('The mean of Excitatory units in SOZ Hippocampus ')
   d_in_hippo_std = gaus_inhib_hippo_units/ sqrt(length(gaus_inhib_hippo_units));
    d_ex_hippo_std = gaus_exc_hippo_units/ sqrt(length(gaus_exc_hippo_units));
   
  figure;hold on;
  shadedErrorBar((1:length(d_in_hippo_mean))/10000, d_in_hippo_mean, d_in_hippo_std , '-m', 2);
  shadedErrorBar((1:length(d_ex_hippo_mean))/10000, d_ex_hippo_mean, d_ex_hippo_std , '-b', 2);
   
  xlim([110 164])
   xlabel('Time [Sec]');
   title ('Hippocampus SOZ units ')
   %saveas(gcf,'Hoppo_units_gaus100','epsc');
    print('Hippo_unit_gaus_quality_100', '-dpng', '-r300')
   %% Entorhinal Cortex
   ent_index = [ 20:27, 83, 106: 111];
   inhib_ent = [ 20, 23, 24, 25, 108, 110];
for i = 1: length(inhib_ent)
   gaus_inhib_ent_units(i,:) = gaussian_100_new{inhib_ent(i)};
end
   
d_in_ent_mean = nanmean( gaus_inhib_ent_units);
d_in_ent_std = nanstd(gaus_inhib_ent_units);
%      figure;plot((1:length(d_in_ent_mean))/10000,d_in_ent_mean)
%    xlabel('Time [Sec]');
%    title ('The mean of Inhibitory units in SOZ Entorhinal cortex ')

 ex_ent = setdiff(ent_index, inhib_ent);
for i = 1: length(ex_ent)
   gaus_exc_ent_units(i,:) = gaussian_100_new{ex_ent(i)};
end
   d_ex_ent_mean = nanmean( gaus_exc_ent_units);
   d_ex_ent_std = nanstd(gaus_exc_ent_units);
   d_in_ent_std = gaus_inhib_ent_units/ sqrt(length(gaus_inhib_ent_units));
   d_ex_ent_std = gaus_exc_ent_units/ sqrt(length(gaus_exc_ent_units));
   
%      figure;plot((1:length(d_ex_ent_mean))/10000,d_ex_ent_mean)
%    xlabel('Time [Sec]');
%    title ('The mean of Excitatory units in SOZ Entorhinal cortex ')
   figure;hold on;
  shadedErrorBar((1:length(d_in_ent_mean))/10000, d_in_ent_mean, d_in_ent_std , '-m', 2);
  shadedErrorBar((1:length(d_ex_ent_mean))/10000, d_ex_ent_mean, d_ex_ent_std , '-b', 2);
  
   xlabel('Time [Sec]');
   title ('Entorhinal SOZ units ')
  xlim([110 170])
 % saveas(gcf,'Entorhinal_units_gaus100','epsc');
  print('Entorhinal_unit_gaus_quality_100', '-dpng', '-r300')
  %% Amygdala
   am_index = [ 1:4, 17:19, 31, 33, 35: 39, 92, 100: 106];

   inhib_am = [ 18,31,33, 37, 38, 39,100, 102: 105];
for i = 1: length(inhib_am)
   gaus_inhib_am_units(i,:) = gaussian_100_new{inhib_am(i)};
end
   d_in_am_mean = nanmean( gaus_inhib_am_units);
   d_in_am_std = nanstd(gaus_inhib_am_units);
   d_in_am_std = gaus_inhib_am_units/ sqrt(length(gaus_inhib_am_units));
   
%      figure;plot((1:length(d_in_am_mean))/10000,d_in_am_mean)
% 
%    xlabel('Time [Sec]');
%    title ('The mean of Inhibitory units in SOZ Amygdala ')

 ex_am = setdiff(am_index, inhib_am);
for i = 1: length(ex_am)
   gaus_ex_am_units(i,:) = gaussian_100_new{ex_am(i)};
end
   
   d_ex_am_mean = nanmean( gaus_ex_am_units);
   d_ex_am_std = nanstd(gaus_ex_am_units);
   d_ex_am_std = gaus_ex_am_units/ sqrt(length(gaus_ex_am_units));
%      figure;plot((1:length(d_ex_am_mean))/10000,d_ex_am_mean)
%   
%    xlabel('Time [Sec]');
%    title ('The mean of Excitatory units in SOZ Amygdala') 
   
   figure;hold on;
  shadedErrorBar((1:length(d_in_am_mean))/10000, d_in_am_mean,  d_in_am_std , '-m', 2);
  shadedErrorBar((1:length(d_ex_am_mean))/10000, d_ex_am_mean,  d_ex_am_std , '-b', 2); 
   title ('Amygdala SOZ units ');
   xlim([110 165]);
%saveas(gcf,'Amygdala_units_guas100','epsc');
  print('Amygdala_unit_gaus_quality_100', '-dpng', '-r300')
 %legend( '0.5\sigma Inhibitory Units', '0.5\sigma Excitatory Units');
%% Contralateral units
% Amygdala
am_con_index =[5, 8,78:82, 93:97];
inhib_con_am = [79,82, 95];%77
for i = 1: length(inhib_con_am)
    gaus_inhib_con_am(i,:) = gaussian_100_new{inhib_con_am(i)};
end
d_in_con_am_mean = nanmean( gaus_inhib_con_am);
d_in_con_am_std = nanstd(gaus_inhib_con_am);
 %figure;plot((1:length(d_in_con_am_mean))/10000,d_in_con_am_mean)
ex_con_am = setdiff(am_con_index, inhib_con_am);
for i = 1: length(ex_con_am)
   gaus_ex_con_am(i,:) = gaussian_100_new{ex_con_am(i)};
end
   
   d_ex_con_am_mean = nanmean( gaus_ex_con_am);
   d_ex_con_am_std = nanstd(gaus_ex_con_am);
    d_in_con_am_std = gaus_inhib_con_am/ sqrt(length(gaus_inhib_con_am));
    d_ex_con_am_std = gaus_ex_con_am/ sqrt(length(gaus_ex_con_am));
    
figure;hold on;
  shadedErrorBar((1:length(d_in_con_am_mean))/10000, d_in_con_am_mean, d_in_con_am_std , '-m', 2);
  shadedErrorBar((1:length(d_ex_con_am_mean))/10000, d_ex_con_am_mean, d_ex_con_am_std , '-b', 2); 
  title ('Amygdala contralateral units  ');
   xlim([110 160]);
   %saveas(gcf,'Amygdala_Cont_units_gaus100','epsc');
     print('Amygdala_cont_gaus_quality_100', '-dpng', '-r300')
   %% Contralateral units
% entorhinal
% There is no Inhibitory entorhinal cortex units
    %% Contralateral units
% Hippocampus
Hippo_con_index =[40:43, 47, 57:61, 72:76, 98:99 ];
inhib_con_Hippo = [41:43, 47, 58, 60];% 57
for i = 1: length(inhib_con_Hippo)
    gaus_inhib_con_Hippo(i,:) = gaussian_100_new{inhib_con_Hippo(i)};
end
d_in_con_Hippo_mean = nanmean( gaus_inhib_con_Hippo);
d_in_con_Hippo_std = nanstd(gaus_inhib_con_Hippo);
% figure;plot((1:length(d_in_con_Hippo_mean))/10000,d_in_con_Hippo_mean)
ex_con_Hippo = setdiff(Hippo_con_index, inhib_con_Hippo);

for i = 1: length(ex_con_Hippo)
   gaus_ex_con_Hippo(i,:) = gaussian_100_new{ex_con_Hippo(i)};
end
   
   d_ex_con_Hippo_mean = nanmean( gaus_ex_con_Hippo);
   d_ex_con_Hippo_std = nanstd(gaus_ex_con_Hippo);
   d_in_con_Hippo_std = gaus_inhib_con_Hippo/ sqrt(length(gaus_inhib_con_Hippo));
   d_ex_con_Hippo_std = gaus_ex_con_Hippo/ sqrt(length(gaus_ex_con_Hippo));
   
figure;hold on;
  shadedErrorBar((1:length(d_in_con_Hippo_mean))/10000, d_in_con_Hippo_mean, d_in_con_Hippo_std , '-m', 2);
  shadedErrorBar((1:length(d_ex_con_Hippo_mean))/10000, d_ex_con_Hippo_mean, d_ex_con_Hippo_std , '-b', 2); 
  title ('Hippocampus contralateral units  ');
   xlim([110 164]);
    %saveas(gcf,'Hippo_Cont_units_guas100','epsc');
    print('Hippo_cont_gaus_quality_100', '-dpng', '-r300')