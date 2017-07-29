clear stft_total;
clear stft_plus;
clear eeg;
load('/gestalt/home/lvf_pac/439.mat');
Fs = eeg.samp_rate;
lvf_start = 261.1;
use_chan = eeg.eeg_data(16,:);
[s,f,t,ps] = spectrogram(use_chan(1,Fs*((lvf_start-43.52)+1):(Fs*(lvf_start+50)+1)), Fs/10, 0,  [8:80], Fs, 'yaxis');
stft_total{1} = {s,f,t,ps};
stft_plus = struct('stft', stft_total, 'lvf_start', lvf_start);
 ps = cell2mat(stft_plus(1).stft(1,4));


figure
subplot(3, 1, 1);
image(ps(1:44, 1:end)/100);
set(gca,'ydir','normal');
set(gca, 'YTick', [4:10:44])
set(gca, 'YTickLabel', [12:10:52])

subplot(3, 1, 2)

plot((1:length(eeg.eeg_data(16,Fs*(lvf_start-43):(Fs*(lvf_start+50)))))/Fs, eeg.eeg_data(16,Fs*(lvf_start-43):(Fs*(lvf_start+50))));

set(gca,'ydir','normal');
set(gca, 'YTick', [4:10:44])
set(gca, 'YTickLabel', [12:10:52])

subplot(3, 1, 3)
figure;
hold on
k=0; 
inh = [18, 20, 23];
exc = [17, 19,21, 22];
 for i =[exc, inh] 
      v_Raster = DBfinal.Raster{i};
     k= k+1;
     if DBfinal.long_unit{i}==0
         if DBfinal.SOZ_code{i}==1
    for l=DBfinal.T_LVF{i}(1)* 10000 - 43* 10000:length(DBfinal.Raster{i})
    Raster_LVF{i}(l) = v_Raster(l);
     if Raster_LVF{i}(l)==1
     x(1:2)=l - DBfinal.T_LVF{i}(1)* 10000;
     y(1:2)=[(k+3-.25) (k+3+.25)];
     if k<=4
     plot(x/10000,y,'blue', 'linewidth',.5);
     else 
         plot(x/10000,y,'red', 'linewidth',.5);
     end
     end;
    end;
    end;
     end;
 end
 print('tf-compare_439', '-dpng', '-r300')