% Looking those channels with one unit and compare their cluster before
% and after LVF. The goal is to show that the centroid of the clusters do
% not changing before and after LVF
% we calculated the PCA for the normalized spikes before LVF. 
% We got the scores and coefficients for before LVF onset and use the same coefficients to
% calculate the scores of the spikes dring LVF.

% For each unit we are interested to look, we have to read the relevant
% patient number from data base, load the data from iEEG 
%%Initialize
t_start = 312.5;%261.1;
t_end = 475;
%data =  load('/gestalt/home/lvf_pac/TJU049_sz2/WC_out_26.mat'); 
%data = load('/gestalt/home/lvf_pac/439/WC_out_16.mat');
load('/gestalt/home/lvf_pac/461_sz1/WC_out_38.mat')
%% totall spikes pre and post LVF
p= 0;
j=0;
k=0;
for i= 1: length(cluster_class)
    
    if cluster_class(i,1)~=0
       
        if cluster_class(i,2)<=t_start * 1000 
            k = k +1;
            cluster_class_new_pre(k) = cluster_class(i,1); % there is no class 2 before LVF
           
            new_spike_pre(k,:) = spikes(i,:) ; % seperating spikes before LVF
        else
            j= j+1;
            cluster_class_new_post(j) = cluster_class(i,1);
            new_spike_post(j,:) = spikes(i,:); % spikes after LVF
        end
    end 
end
%% spikes devided to each class for pre and post seperately
for i = 1:length (cluster_class_new_pre)
    if cluster_class_new_pre(i) ==1
        p=p+1;
        spike_pre_class_1(p,:)= new_spike_pre(i,:); % spikes form of class 1 before LVF
%     else 
%         q= q+1; % In case we have two units (clusters) in our channel
%         spike_pre_class_2(p,:)= new_spike_pre(i,:); % spikes form of class 2 before LVF
    end
end
 
index_pre_1 =[];
index_post_1=[];
index_post_2=[];
p=0;
q=0;
for i = 1:length (cluster_class)
    if cluster_class(i,2)<= t_start * 1000
        if cluster_class(i) ==1
           index_pre_1 = [index_pre_1, i];
        end
    else
       if cluster_class(i) ==1
        p=p+1;
        index_post_1= [ index_post_1, i];  % find which spikes after LVF are belong to class 1
        spike_post_class_1(p,:)= spikes(i,:); % spikes form of class 1 after LVF
%        else 
%         q= q+1;
%         index_post_2= [index_post_2, i];    % find which spikes after LVF are belong to class 2
%         spike_post_class_2(q,:)= spikes(i,:); % spikes form of class 2 after LVF
       end

    end
end
%% Calculate pre principal components
new_spike_pre_norm = zscore(new_spike_pre);
new_spike_post_norm = zscore(new_spike_post);
[COEFF_pre SCORE_pre LATENT_pre]=princomp(new_spike_pre_norm);

%% Plot PC1 vs PC2
figure
hold on
scatter(SCORE_pre(1,:),SCORE_pre(2,:), 'marker', 'o');
mean_pre = mean([SCORE_pre(1,:);SCORE_pre(2,:)], 2);
hold on 
plot(mean_pre(1), mean_pre(2), 'g^',  'MarkerSize', 12)


%% Apply pre principal components to post datanew_spike_post_norm = zscore(new_spike_post);
SCORE_post=new_spike_post_norm*COEFF_pre;
mean_post = mean([SCORE_post(1,:);SCORE_post(2,:)], 2);
scatter(SCORE_post(1,:),SCORE_post(2,:), 'marker', 'd'); 
hold on
plot(mean_post(1), mean_post(2), 'm^',  'MarkerSize', 12)
legend( 'before LVF','Centroid of cluster before LVF','After LVF', 'Centroid of cluster after LVF');
title('Inhibitory unit spike cluster before and after LVF')
xlabel('PCA1')
ylabel('PCA2')
saveas(gcf,'Inh38_unit_clusters','epsc');

d = mahal( mean_pre', [SCORE_post(1,:);SCORE_post(2,:)]')
