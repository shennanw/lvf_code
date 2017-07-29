% By using the spread sheetand calculated features we will classify the
% neurons to inhibitory and excitatory by using Kmean clustering. 
% We also demonstrated the mean of each group to show that the mean of the
% shape of neurons are different as they classified differently
% Then we claassified the neurons in each rigion separately and we find
% that inhibitory and excitory neurons are better to classified in
% hippocampus
spike_param = xlsread('/gestalt/home/lvf_pac/Xeno/spikes_param_f6.xlsx');
peak2trough = spike_param(:,7);
peak_amplitude_asymmetry = spike_param(:,8);
halfwidth = spike_param(:,3);

input_kmean= [halfwidth,peak2trough,peak_amplitude_asymmetry];
spike_mean_notempty = DBfinal.spike_mean(~cellfun('isempty', DBfinal.spike_mean));

[idx, PP]= kmeans(input_kmean, 2);
figure;
plot3(input_kmean(idx==2,1),input_kmean(idx==2,2),input_kmean(idx==2, 3),'r.','MarkerSize',12)
hold on
plot3(input_kmean(idx==1,1),input_kmean(idx==1,2),input_kmean(idx==1, 3),'b.','MarkerSize',12 )
hold on
plot3(PP(:,1), PP(:,2), PP(:,3), 'kx','MarkerSize',12 , 'LineWidth', 3);
xlabel('Halfwidth')
ylabel('Trough to Peak')
zlabel('Peak Amplitude asymmetry')
legend('Putative inhibitatory','Putative excitatory', 'Centroid')
title('Kmean Clustering Analysis')
saveas(gcf,'Kmean_clustering_halfwidth_rev','epsc');

cluster_1 = find(idx==1);
cluster_2 = find(idx==2);
for i = 1:length(cluster_1)
spike_cluster_1(i,:) = spike_mean_notempty{cluster_1(i)};
end
figure;plot(mean(spike_cluster_1) );title(' Mean of all Excitatory units');


saveas(gcf,'Excitatory_clustering_REV','epsc');

%title('Clustering for all units ')





