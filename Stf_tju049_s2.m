name = '/gestalt/home/nxe022/NathanCode/MicroViewerandTesting/TJ049sz2-LVFclips/TJ049_sz2_14:14:4-14:23:4__';
Fs= 32556; 
freq = 32556;
stft_total = {};
%load('/gestalt/home/lvf_pac/462_extended.mat');

filetitle = 'TJ049sz2';
eeg_data_total = {};

chan = 10;%[22];
lvf_start = 447.2;%[449.6];
lvf_end = 464;%[462.3];
chan_name = {'TJ049sz2 LPH'};



for cc = 1:length(chan)
disp(chan(cc))
%use_chan = downsample(eeg.eeg_data(chan(cc),:),30);
load(strcat(name, num2str(chan(cc)), '.mat'));
use_chan = data;

[s,f, t, ps] = spectrogram(use_chan(1,Fs*(lvf_start(cc)-33):(Fs*(lvf_start(cc)+17))), Fs/10, 0,  [8:80], Fs, 'yaxis');
stft_total{end+1} = {s,f,t,ps};

end

stft_plus = struct('stft', stft_total, 'lvf_start', lvf_start);

for cc = 1:length(stft_total)
    ps = cell2mat(stft_plus(cc).stft(1,4));
A = figure;
figure
subplot(311);
image(ps(1:44, 1:end));
set(gca,'ydir','normal');


set(gca, 'XTickLabel',  [-43:10:15])
set(gca, 'YTickLabel', [])

subplot(312)
plot(1:length(Fs*(lvf_start(cc)-33):(Fs*(lvf_start(cc)+17))), use_chan(1,Fs*(lvf_start(cc)-33):(Fs*(lvf_start(cc)+17))))


xlim([0,length(Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17)))])
set(gca, 'XTickLabel', [-43:10:15])
set(gca, 'YTickLabel', [])

end

subplot(3, 1, 3)
figure
hold on
k=0; 
t = 0;
inh = [41 42 43 44 47 58 60 61];
exc = [40 45 46 48 49 50 51 52 53 54 55 56 57 59];
 for i =[exc inh] 
      v_Raster = DBfinal.Raster{i};
     k= k+1;
     if DBfinal.long_unit{i}==0
         if DBfinal.SOZ_code{i}==1
             t = t +1;
    for l= DBfinal.T_LVF{i}(1)* 10000 - 43* 10000  :length(DBfinal.Raster{i})
    Raster_LVF{i}(l) = v_Raster(l);
     if Raster_LVF{i}(l)==1
       
     x(1:2) = l-DBfinal.T_LVF{i}(1)* 10000 ;
     y(1:2)=[(t+3-.25) (t+3+.25)];
     if k<=12
     plot(x/10000,y,'blue ', 'linewidth',.5);
     else
     plot(x/10000,y,'red ', 'linewidth',.5); 
    end
     end
     end;
         end
    end;
 end
 print('tf-compare_tju049_rev_SZ_2', '-dpng', '-r300')