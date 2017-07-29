name = '/gestalt/home/lvf_pac/462_extended.mat';
Fs= 40000; 
freq = 40000;
stft_total = {};
%load('/gestalt/home/lvf_pac/462_extended.mat');

filetitle = '462ex';
eeg_data_total = {};


% chan = [3 4 5 19 22 24 26];
% lvf_start = [472 472 472 449 449.6 450.1 448.2];
% lvf_end = [488 488 488 470 462.3 468 475];
% chan_name = {'RPH3','RPH4','RPH5','LPH2','LPH5', 'LPH6', 'LPH8'};
chan = [21, 15, 116];
lvf_start = [43.5, 53, 5, 43, 84];
%lvf_end = [504.4];
%chan_name = {'462ex LMH'};

load(name);

%spectrogram(use_chan, Fs/10, 0,  [8:50], Fs, 'yaxis');

for cc = 1:length(chan)
disp(chan(cc))
%use_chan = downsample(eeg.eeg_data(chan(cc),:),30);
%use_chan = downsample(use_chan.data, 32);
%load(strcat(name, num2str(cc), '.mat'));
%numTBins = length(use_chan(1,Fs*(lvf_start(cc)-180):Fs*(lvf_start(cc)+20)))/3255;
[s,f, t, ps] = spectrogram(eeg.eeg_data(chan(cc),Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17))), Fs/10, 0,  [8:80], Fs, 'yaxis');
stft_total{end+1} = {s,f,t,ps};
end

stft_plus = struct('stft', stft_total, 'lvf_start', lvf_start);
i=0;
for cc = 1:length(stft_total)
    ps = cell2mat(stft_plus(cc).stft(1,4));
A = figure;
%figure
i = i+1;
subplot(7, 1, i);
image(ps(1:44, 1:end));
set(gca,'ydir','normal');
title(chan_name{cc})

set(gca, 'XTickLabel', [])
set(gca, 'YTickLabel', [])


i=i+1;
subplot(7, 1, i)
plot(1:length(Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17))), eeg.eeg_data(chan(cc),Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17))))

hold on
redline = zeros(1,15001);
redline(:,:) = (lvf_end(cc)-lvf_start(cc)+43)*Fs;
plot(redline, [-10000:5000], 'r')
xlim([0,length(Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17)))])
set(gca, 'XTickLabel', [])
set(gca, 'YTickLabel', [])

end

subplot(7, 1, 7)
hold on
k=0; 
inh = [77 79 82 88 92];
exc = [68 70 71 72 73 74 75 76 78 80 81 83 84 85 86 87 89 90 91];
 for i =[inh exc] 
      v_Raster = DBfinal.Raster{i};
     k= k+1;
     if DBfinal.long_unit{i}==0
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
    end;
 end
 