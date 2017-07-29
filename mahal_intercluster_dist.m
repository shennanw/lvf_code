% To show the difference between Mahalanobis distance of inhibitory and
% excitatory using bargraph and Histogram (We didnt use bargraph)
mahal_file = xlsread('Mahalanobis-4.xlsx', 'A:B');
unit_num = mahal_file(:,1);
mahal_dis = mahal_file(:,2);
mahal_dis_sq = (mahal_dis).^2;
inhib_unit = [20, 23, 24, 25,31, 41,42,43, 44, 47, 58, 60, 61, 62, 63, 77,79, 82, 88, 92, 95, 100, 102, 105, 108, 113];
 [sharedVals,idxsIntomahal] = intersect(unit_num,inhib_unit,'stable');
 excit_units = setdiff(1:length(unit_num), idxsIntomahal);
 ind_excit = find(excit_units);
model_inh =mahal_dis_sq(idxsIntomahal);
model_exc = mahal_dis_sq(ind_excit);
figure;bar([mean(model_inh),mean(model_exc)])
hold on
errorbar([mean(model_inh) , mean(model_exc)], [std(model_inh), std(model_exc)], '.r')
xlim([0 3])
set(gca,'Xtick',1:2,'XTickLabel',{'Inhibitory Units','Excitatory Units'})
title('Mahalanobis intercluster distance before and after LVF for Inhibitory and Excitatory units');
saveas(gcf,'mahaldist_sqrt','epsc');


%% Histogram
figure;
 histfit(model_inh);
xlim ([0,3])
hold on;
histfit(model_exc)
xlim([0,1.5])
ylim([0 12])
xlabel('Mahalanobis intercluster distance squared')
saveas(gcf,'critic_rev1','epsc');

figure;
map = brewermap(2,'set1');
histf(model_inh, 'facecolor','m', 'facealpha',0.9,'edgealpha', 0.9);
hold on 
histf(model_exc, 'facecolor','b', 'facealpha',0.2,'edgealpha', 0.3 )
box off

