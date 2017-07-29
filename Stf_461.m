name = '/gestalt/home/lvf_pac/461_sz1.mat';
Fs= 30000; 
freq = 30000;
stft_total = {};
%load('/gestalt/home/lvf_pac/462_extended.mat');

filetitle = '461';
eeg_data_total = {};

chan = 54;%[38];
lvf_start = 312.3;% [312.8];
lvf_end = 317.5;%[325];
chan_name = {'461 LEC'};

load(name);
use_chan = eeg.eeg_data(chan,:);
clear eeg

for cc = 1:length(chan)
disp(chan(cc))
%use_chan = downsample(eeg.eeg_data(chan(cc),:),30);
%use_chan = downsample(use_chan.data, 32);
%load(strcat(name, num2str(cc), '.mat'));
%numTBins = length(use_chan(1,Fs*(lvf_start(cc)-180):Fs*(lvf_start(cc)+20)))/3255;
[s,f, t, ps] = spectrogram(use_chan(1,Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17))), Fs/10, 0,  [8:80], Fs, 'yaxis');
stft_total{end+1} = {s,f,t,ps};

end

stft_plus = struct('stft', stft_total, 'lvf_start', lvf_start);

for cc = 1:length(stft_total)
    ps = cell2mat(stft_plus(cc).stft(1,4));
A = figure;
%figure
subplot(311);
image(ps(1:44, 1:end));
set(gca,'ydir','normal');

set(gca, 'XTickLabel', [-43:10:15])
set(gca, 'YTickLabel', [12:10:52])

subplot(312)
plot(1:length(Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17))), use_chan(1,Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17))))

xlim([0,length(Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17)))])
set(gca, 'XTickLabel', [-43:10:15])
set(gca, 'YTickLabel', [12:10:52])

end

subplot(3, 1, 3)
figure;
hold on
k=0; 
inh = [24 25 31 33 37 38 39];
exc = [26 27 28 29 30 35 36];
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
     if k <= 7
     plot(x/10000,y,'blue ', 'linewidth',.5);
     else
        plot(x/10000,y,'red', 'linewidth',.5); 
     end
     end
     end;
        end;
     end
 end
 
 print('tf-compare_461', '-dpng', '-r300')