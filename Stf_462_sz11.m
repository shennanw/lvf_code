name = '/gestalt/home/lvf_pac/462_sz11_16_1044.mat';
Fs= 40000; 
freq = 40000;
stft_total = {};

eeg_data_total = {};

chan = [21, 15, 116];
lvf_start = [43.5, 43.5, 43.84];
lvf_start = 43.84;chan = 116;

load(name);


for cc = 1:length(chan)
disp(chan(cc))
use_chan = eeg.eeg_data(chan(cc),:);
[s,f, t, ps] = spectrogram(use_chan(1,Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17))), Fs/10, 0,  [8:80], Fs, 'yaxis');
stft_total{end+1} = {s,f,t,ps};
end

stft_plus = struct('stft', stft_total, 'lvf_start', lvf_start);
i=0;
figure;
for cc = 1:length(stft_total)
    ps = cell2mat(stft_plus(cc).stft(1,4));


i = i+1;
subplot(7, 1, i);
image(ps(1:44, 1:end));
set(gca,'ydir','normal');


set(gca, 'XTickLabel', [])
set(gca, 'YTickLabel', [])


i=i+1;
subplot(7, 1, i)
plot(1:length(Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17))), use_chan(1,Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17))))

hold on
redline = zeros(1,15001);
redline(:,:) = (lvf_end(cc)-lvf_start(cc)+43)*Fs;
plot(redline, [-10000:5000], 'r')
xlim([0,length(Fs*(lvf_start(cc)-43):(Fs*(lvf_start(cc)+17)))])
set(gca, 'XTickLabel', [])
set(gca, 'YTickLabel', [])

end

subplot(7, 1, 7)
figure;
hold on
k=0; 
inh = [100 102:105, 108, 113 ];
exc = [93: 99, 101, 106, 107, 109,110, 111, 112];
 for i =[exc inh] 
      v_Raster = DBfinal.Raster{i};
       k= k+1;
     if DBfinal.long_unit{i}==0
         if DBfinal.SOZ_code{i}==1
           
    for l= 1:length(DBfinal.Raster{i})
    Raster_LVF{i}(l) = v_Raster(l);
     if Raster_LVF{i}(l)==1
     x(1:2) = l -DBfinal.T_LVF{i}(1)* 10000;
     y(1:2)=[(k+3-.25) (k+3+.25)];
     if k <= 14
     plot(x/10000,y,'blue ', 'linewidth',.5);
     else
     plot(x/10000,y,'red', 'linewidth',.5);    
     end
     end
     end;
         end
    end;
 end
 