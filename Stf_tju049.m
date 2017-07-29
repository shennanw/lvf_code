name = '/gestalt/home/nxe022/NathanCode/MicroViewerandTesting/TJ049sz1-LVFclips/TJ049_sz1_23:38:3-23:41:3__';
Fs= 32556; 
freq = 32556;
stft_total = {};

filetitle = 'TJ049sz1';
eeg_data_total = {};


chan = [24];
lvf_start = [271.9];
lvf_end = [279.5];

chan_name = {'TJ049sz1 LPH6'};


cc=1;
disp(chan(cc))

load(strcat(name, num2str(chan(cc)), '.mat'));
use_chan = data;

[s,f, t, ps] = spectrogram(use_chan(1,Fs*(lvf_start(cc)-30):(Fs*(lvf_start(cc)+30))), Fs/10, 0,  [8:80], Fs, 'yaxis');
stft_total{1} = {s,f,t,ps};


stft_plus = struct('stft', stft_total, 'lvf_start', lvf_start);

    ps = cell2mat(stft_plus(cc).stft(1,4));
 figure;

subplot(311);
image(ps(1:44, 1:end));
set(gca,'ydir','normal');

set(gca, 'XTickLabel', [])
set(gca, 'YTickLabel', [12:10:52])


subplot(312)
plot((1:length(use_chan(1,Fs*(lvf_start(cc)-30):(Fs*(lvf_start(cc)+30)))))/Fs, use_chan(1,Fs*(lvf_start(cc)-30):(Fs*(lvf_start(cc)+30))))
set(gca, 'XTickLabel', [])
set(gca, 'YTickLabel', [12:10:52])


subplot(313)
figure;
hold on
k=0;
inh = [62];
exc = [64, 65, 66];
 for i =[exc, inh] 
      v_Raster = DBfinal.Raster{i};
     k= k+1;
     if DBfinal.long_unit{i}==0
         if DBfinal.SOZ_code{i}==1
    for l=DBfinal.T_LVF{i}(1)* 10000 - 30* 10000:length(DBfinal.Raster{i})
    Raster_LVF{i}(l) = v_Raster(l);
     if Raster_LVF{i}(l)==1
     x(1:2)=l - DBfinal.T_LVF{i}(1)* 10000;
     y(1:2)=[(k+3-.25) (k+3+.25)];
     if k<=3
     plot(x/10000,y,'blue', 'linewidth',.5);
     else 
     plot(x/10000,y,'red', 'linewidth',.5);
     end
     end;
    end;
    end;
     end
 end



print('tf-compare_tju049', '-dpng', '-r300')clear eeg stft_plus 