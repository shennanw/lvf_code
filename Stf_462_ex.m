name = '/gestalt/home/lvf_pac/462_extended.mat';
Fs= 30000; 
freq = 30000;
stft_total = {};

filetitle = '462ex';
eeg_data_total = {};


% chan = [3 4 5 19 22 24 26];
% lvf_start = [472 472 472 449 449.6 450.1 448.2];
% lvf_end = [488 488 488 470 462.3 468 475];
% chan_name = {'RPH3','RPH4','RPH5','LPH2','LPH5', 'LPH6', 'LPH8'};
chan = 44;
unit = 87;
lvf_start = DBfinal.T_LVF{unit}(1);
lvf_end = DBfinal.T_LVF{unit}(2);
%chan_name = {'462ex LEC'};

load(name);
use_chan = eeg.eeg_data(chan,:);
%clear eeg




[s,f, t, ps] = spectrogram(use_chan(1,Fs*(lvf_start-43):(Fs*(lvf_start+10))), Fs/10, 0,  [8:80], Fs, 'yaxis');
stft_total{1} = {s,f,t,ps};
stft_plus = struct('stft', stft_total, 'lvf_start', lvf_start)
  ps = cell2mat(stft_plus(cc).stft(1,4));
A = figure;
%figure
subplot(311);
figure;image(ps(1:44, 1:end));
set(gca,'ydir','normal');

set(gca, 'XTickLabel', []);
set(gca, 'YTickLabel', []);
set(gca,'xtick',[]);

subplot(312)
figure;plot((1:length(use_chan(1,Fs*(lvf_start-43):(Fs*(lvf_start+10)))))/Fs, use_chan(1,Fs*(lvf_start-43):(Fs*(lvf_start+10))))

xlim([0,length(Fs*(lvf_start(cc)-43):(Fs*(lvf_start+17)))/Fs])
set(gca, 'XTickLabel', [])
set(gca, 'YTickLabel', [])
set(gca,'xtick',[])

subplot(3, 1, 3)
figure;
hold on
k=0; 

inh = [77 79 82 88 92];
exc = [68 70 71 72 73 74 75 76 78 80 81 83 84 85 86 91 87 89 90];
 for i =[exc inh] 
      v_Raster = DBfinal.Raster{i};
     k= k+1;
     if DBfinal.long_unit{i}==0
         if DBfinal.SOZ_code{i} ==1
    for l= DBfinal.T_LVF{i}(1)* 10000 - 43* 10000  :length(DBfinal.Raster{i})
    Raster_LVF{i}(l) = v_Raster(l);
     if Raster_LVF{i}(l)==1
     x(1:2) = l-DBfinal.T_LVF{i}(1)* 10000 ;
     y(1:2)=[(k+3-.25) (k+3+.25)];
     if k <= 19
     plot(x/10000,y,'blue ', 'linewidth',.5);
     else
     plot(x/10000,y,'red', 'linewidth',.5); 
     end
     end
     end;
         end
    end;
 end
 
 
 print('tf-compare_462_ex_raster_chan44', '-dpng', '-r300')