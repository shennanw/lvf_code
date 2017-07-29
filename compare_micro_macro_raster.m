% Comparison of Micro and Macro and Raster for 462 
load('/gestalt/home/lvf_pac/462_sz11_16_1044.mat');
LEC7 = eeg.eeg_data(21,:);
LEC1 = eeg.eeg_data(15,:);
LMH1 = eeg.eeg_data(22,:);
GB2_LMH1 = eeg.eeg_data(118,:);
GB1_LEC7 = eeg.eeg_data(116,:);
GB1_LEC1 = eeg.eeg_data(110,:);




figure;
subplot(3,1,1)
time = (1:length(LMH1))/40000;
plot(time - 48.52, LMH1)
xlim([-15 70-48.52])
xlabel('Time [Sec]')
legend('Macro elecrode LMH1')
subplot(3,1,2)
plot(time - 48.52, GB2_LMH1)
xlim([-15 70-48.52])
xlabel('Time [Sec]')
legend('Micro elecrode LMH1')
subplot(3,1,3)
hold on
 v_Raster = DBfinal.Raster{112};
for l=1:length(DBfinal.Raster{112})
    Raster_LVF{112}(l) = v_Raster(l);
if Raster_LVF{112}(l)==1
x(1:2)=l -48.52 * 10000;
y(1:2)=[(1-.25) (1+.25)];
plot(x/10000,y,'black', 'linewidth',.5);
xlabel('Time [Sec]')
legend('Raster plot LMH1')
end;
end;
set(gca,'fontsize',16)
saveas(gcf,'comparison_LMH1','epsc');

figure;
subplot(4,1,1)
time = (1:length(LEC7))/40000;
plot((1:length(LEC7))/40000, LEC7)
xlim([0 70])
% xlabel('Time [Sec]')
% legend('Macro elecrode LEC7')
subplot(4,1,2)
plot((1:length(LEC1))/40000, LEC1)
 xlim([0 70])
 xlabel('Time [Sec]')
 legend('Macro elecrode LEC1')
 subplot(4,1,3)
plot((1:length(GB1_LEC7))/40000, GB1_LEC7)
xlim([0 70])
xlabel('Time [Sec]')
legend('Micro elecrode')
subplot(4,1,4)
hold on
k=0; 
inhib = [95, 100, 102,103, 104, 105, 108, 113];
exci =[96, 97, 98, 99, 101, 106, 107, 109, 110, 111, 112];
 for i =[exci, inhib] 
      v_Raster = DBfinal.Raster{i};
     k= k+1;
    for l=1:length(DBfinal.Raster{i})
    Raster_LVF{i}(l) = v_Raster(l);
     if Raster_LVF{i}(l)==1
     x(1:2)=l- DBfinal.T_LVF{i}(1)* 10000;
     y(1:2)=[(k+3-.25) (k+3+.25)];
     if k<=11
     plot(x/10000,y,'blue', 'linewidth',.5);
     else
     plot(x/10000,y,'red', 'linewidth',.5);
     end
     xlabel('Time [Sec]')
     %legend('Putative excitatory', 'Putative inhibitory')
     end;
    end;
 end
saveas(gcf,'comparison_LEC7_LEC1_raster_rev2','epsc');

figure;
 subplot(3,1,1)
 plot((1:length(LEC1))/40000, LEC1)
 xlim([0 70])
 xlabel('Time [Sec]')
 legend('Macro elecrode LEC1')
 subplot(3,1,2)
 plot((1:length(GB1_LEC1))/40000, GB1_LEC1)
 xlim([0 70])
xlabel('Time [Sec]')
 legend('Micro elecrode LEC1')
 subplot(3,1,3)
 hold on
k=0; 
inhib = [95, 100, 102,103, 104, 105, 108, 113];
exci =[96, 97, 98, 99, 101, 106, 107, 109, 110, 111, 112];
 for i =[exci, inhib] 
      v_Raster = DBfinal.Raster{i};
     k= k+1;
    for l=DBfinal.T_LVF{i}(1)* 10000 - 43* 10000:length(DBfinal.Raster{i})
    Raster_LVF{i}(l) = v_Raster(l);
     if Raster_LVF{i}(l)==1
     x(1:2)=l-DBfinal.T_LVF{i}(1);
     y(1:2)=[(k+3-.25) (k+3+.25)];
     if k<=11
     plot(x/10000,y,'blue', 'linewidth',.5);
     else
     plot(x/10000,y,'red', 'linewidth',.5);
     end
     xlabel('Time [Sec]')
     legend('Putative excitatory', 'Putative inhibitory')
     end;
    end;
 end
% saveas(gcf,'comparison_LEC1','epsc');







