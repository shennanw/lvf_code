% Multiunit Analysis for just certain number of neurons using threshold and
% not the output of waveclus. 
% For each unit that we want to use, we need to read from the related
% eegfile from iEEG folder
% First we need to correlate the unit number with patient number in
% database and then load the data related to that patient and for getting
% access to channel number, the channel number should be read from the same
% unit in database


% clear eeg
% load('/gestalt/home/lvf_pac/461_sz1.mat')
%load('/gestalt/home/lvf_pac/462_sz11_16_1044.mat')
spikes_pre=[];
spikes_post = [];
spike_pre_norm=[];
spike_post_norm =[];
SCORE_pre=[];
COEFF_pre = [];
SCORE_post =[];
mean_pre=[];
mean_post=[];

unit = 25;
ch = DBfinal.chan_num{unit};
Fs = eeg.samp_rate;
lvf_start = DBfinal.T_LVF{unit}(1);
  lvf_end = DBfinal.T_LVF{unit}(2);
  
  p=0;
  q=0;
 %eegf = eeg_filter(eeg, 300, 3000);%filtering eeg
mad_mua = mad(eegf.eeg_data(ch,1:lvf_end*Fs),1); % median of the filtered eeg
threshold = 5.92*mad_mua;
mua_peaks = find_inflections(eegf.eeg_data(ch,1:lvf_end*Fs),'minima');% find the index of peak
spike_count=0;
  for p = 1:length(mua_peaks)
        t = mua_peaks(p);
        if t>33
        if eegf.eeg_data(ch,t) < -threshold
          spike_count=spike_count+1;
          spikes(spike_count,:)=eegf.eeg_data(ch,(t-32):(t+31)); 
          if t-300 <1  % for those early spikes
              begine =1;
              baseline_correct=mean(eegf.eeg_data(ch,begine:(t+300)));
         
          elseif t+300>length(eegf.eeg_data(ch,1:lvf_end*Fs))  % if the t+300 is more than the length of te signal which is till end of LVF
             baseline_correct=mean(eegf.eeg_data(ch,(t-300):length(eegf.eeg_data(ch,1:lvf_end*Fs))));
          
          else
          baseline_correct=mean(eegf.eeg_data(ch,(t-300):(t+300)));
          end
          if t<lvf_start * Fs
              p =p+1;
          spikes_pre(p,:)=spikes(spike_count,:)-baseline_correct;
          else 
              q = q+1;
          spikes_post(q,:)=spikes(spike_count,:)-baseline_correct; 
          end
        end
        end
  end

 
spike_pre_norm = zscore(spikes);
spike_post_norm = zscore(spikes_post);
[COEFF_pre, SCORE_pre, LATENT_pre]=pca(spike_pre_norm);

%% Plot PC1 vs PC2
figure
hold on
scatter(SCORE_pre(1,:),SCORE_pre(2,:), 'marker', 'o');
mean_pre = mean([SCORE_pre(1,:);SCORE_pre(2,:)], 2);
hold on 
plot(mean_pre(1), mean_pre(2), 'g^',  'MarkerSize', 12)

SCORE_post=spike_post_norm*COEFF_pre;
mean_post = mean([SCORE_post(1,:);SCORE_post(2,:)], 2);
scatter(SCORE_post(1,:),SCORE_post(2,:), 'marker', 'd');
hold on
plot(mean_post(1), mean_post(2), 'm^',  'MarkerSize', 12)
legend( 'before LVF','Centroid of cluster before LVF','After LVF', 'Centroid of cluster after LVF');
title('24')
% Mahalanobis distance
d = mahal( mean_pre', [SCORE_post(1,:);SCORE_post(2,:)]')
%% plot the histogram of 15 inhibitory and 15 excitatory units
mahal_file_multi = xlsread('mahalanobis_Multi.xlsx', 'A:B'); % read the value from excel file
unit_num = mahal_file_multi(:,1);
mahal_dis = mahal_file_multi(:,2);
mahal_dis_sq = (mahal_dis).^2;
mahal_inh_unit = unit_num(1:8);
mahal_exc_unit = unit_num(9:16);
mahal_dis_inh_sq = mahal_dis_sq(1:8);
mahal_dis_exc_sq = mahal_dis_sq(9:16);



figure;
histfit(mahal_dis_inh_sq);
xlim ([0,0.6])
hold on;
histfit(mahal_dis_exc_sq)
xlim([0,0.6])
ylim([0 8])
xlabel('Mahalanobis intercluster distance squared')
% saveas(gcf,'multiunit_critic_multi','epsc');

%% show raw the spikes before andd after LVF
figure;
plot(spikes(1:6,:)', 'b');
hold on
plot(spikes_post(1:6,:)', 'r');

