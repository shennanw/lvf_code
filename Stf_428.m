
% These series of codes show the plots we have in manuscript with TF plot,
% raw data and raster all togeter.
% For each data, we created a new mfile so it is easy to just run the
% program.
% The units that is in interest should be corelated to the channel number
% of te same unit and this correlation should be done by data base
% All parameters were called from data base

clear stft_total;
clear stft_plus;
load('/gestalt/home/lvf_pac/428_sz.mat');
Fs = eeg.samp_rate;
unit = 4;
lvf_start = DBfinal.T_LVF{unit}(1);
chan = 8;
use_chan = eeg.eeg_data(8,:);
[s,f,t,ps] = spectrogram(use_chan(1,Fs*((lvf_start-43)+1):(Fs*(lvf_start+17)+1)), Fs/10, 0,  [8:80], Fs, 'yaxis');
stft_total{1} = {s,f,t,ps};
stft_plus = struct('stft', stft_total, 'lvf_start', lvf_start);
 ps = cell2mat(stft_plus(1).stft(1,4));


figure
subplot(3, 1, 1);
figure;image(ps(1:44, 1:end));
set(gca,'ydir','normal');
%set(gca, 'YTick', [4:10:44])
set(gca, 'YTickLabel', [12:10:52])

subplot(3, 1, 2)
figure;plot((1:length(eeg.eeg_data(8,Fs*(lvf_start-43):(Fs*(lvf_start+17)))))/Fs, eeg.eeg_data(8,Fs*(lvf_start-43):(Fs*(lvf_start+17))));
set(gca, 'YTick', [4:10:44]);
hold on
p = zeros(1,45);
p(:,:) = (319-lvf_start+42);
hold on
plot(p, [0:44], 'r')
set(gca, 'XTickLabel', [-43:10:15])
%set(gca, 'YTick', [4:10:44])
set(gca, 'YTickLabel', [12:10:52])
ylabel('μV')
subplot(3, 1, 3)
figure;
hold on
k=0; 

 for i =[ 5:16 1:4] 
      v_Raster = DBfinal.Raster{i};
     k= k+1;
     if DBfinal.long_unit{i}==0
         if DBfinal.SOZ_code{i}==1
    for l= DBfinal.T_LVF{i}(1)* 10000 - 43* 10000  :length(DBfinal.Raster{i})
    Raster_LVF{i}(l) = v_Raster(l);
     if Raster_LVF{i}(l)==1
     x(1:2) = l-DBfinal.T_LVF{i}(1)* 10000 ;
     y(1:2)=[(k+3-.25) (k+3+.25)];
     plot(x/10000,y,'blue ', 'linewidth',.5);
     end
     end;
         end;
    end;
 end