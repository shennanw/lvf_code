% This code generates the raster plot based on all the values in data base.
% The order of patients and units are not the same as data base as we
% wanted to show them more efficietnly.
% between each patients there is a certain distance (4 may be) which can be changed
% on the code
% read the units on raster plot based on this code not based on the units
% in database since the order of them changed for visualization purpose
% each unit depends it is inhibitory or excitatry, in or out of SOZ colored
% diferently
length_raster = cellfun('length',DBfinal.Raster);
max_length_raster = max(length_raster);
for i = 1:length(DBfinal.Raster)
DBfinal.Raster{i}(length(DBfinal.Raster{i})+1:max_length_raster)=0;
end


%% Raster plot 
inhib = [18, 20, 23, 24, 25,31,33,37, 38, 39 41,42,43, 44, 47, 58, 60, 61, 62, 63, 77,79, 82, 88, 92, 95, 100, 102:105, 108, 113];
%contralateral_units = [19, 17, 18, 40, 41, 42, 43, 55, 56 ];
p=[17, 24, 40, 62, 67, 93];
k= 0;
 ind = [93:113, 67:92, 24:39, 17:23, 5:16, 1:4, 62:66, 40, 47, 57:61,41:43 ,44: 46, 48:51, 52:56 ];
figure
hold on;
for i = ind
    k= k+1;
        inhib_index = find(inhib==i);        
       % contralateral_index = find(contralateral_units ==i);
     if (DBfinal.long_unit{i}==0) %&& (isempty(contralateral_index)) % Do not show long units or controlateral units
    v_Raster = DBfinal.Raster{i};
    for j = 1: max_length_raster 
    Raster_LVF{i}(j) = v_Raster(j);
     if  Raster_LVF{i}(j)==1 
            x(1:2)=j - DBfinal.T_LVF{i}(1)* 10000;  
            if i>=93
                 y(1:2)=[(k+2-.25) (k+2+.25)]; 
            elseif (i==92)|| (i>66)                
                  y(1:2)=[(k+5-.25) (k+5+.25)];
               elseif (i==24)|| (i>24&& i<40)
            y(1:2)=[(k+9-.25) (k+9+.25)];
            elseif (i==17)|| (i>17 && i<24)
            y(1:2)=[(k+13-.25) (k+13+.25)];
            elseif (i==5)|| ( i<=16)
            y(1:2)=[(k+17-.25) (k+17+.25)];
            elseif (i==62)|| (i>62 && i<67)
            y(1:2)=[(k+21-.25) (k+21+.25)];
            else
            y(1:2)=[(k+25-.25) (k+25+.25)];
            
         
            end
       
            
            if DBfinal.SOZ_code{i}==1
                plot(x,y,'green', 'linewidth',.5); % SOZ units show is green
                if ~isempty(inhib_index)
                   plot(x,y,'red', 'linewidth',.5); % Inhibitory and SOZ units show in red
                end
            
            else
               plot(x,y,'black', 'linewidth',.5);  % neither inhibitory nor SOZ units show in black
                if ~isempty(inhib_index)
                   plot(x,y,'blue', 'linewidth',.5); % Just inhibitory units show in blue
                end
            end
     end
            if j == DBfinal.T_LVF{i}(2) * 10000
               x(1:2)=j - DBfinal.T_LVF{i}(1)* 10000;
                  if i>=93
                 y(1:2)=[(k+2-.25) (k+2+.25)]; 
            elseif (i==92)|| (i>66)                
                  y(1:2)=[(k+5-.25) (k+5+.25)];
                  elseif (i==24)|| (i>24&& i<40)
            y(1:2)=[(k+9-.25) (k+9+.25)];
            elseif (i==17)|| (i>17 && i<24)
            y(1:2)=[(k+13-.25) (k+13+.25)];
            elseif (i==5)|| (i<=16)
            y(1:2)=[(k+17-.25) (k+17+.25)];
            elseif (i==62)|| (i>62 && i<67)
            y(1:2)=[(k+21-.25) (k+21+.25)];
            else
            y(1:2)=[(k+25-.25) (k+25+.25)];
                  end
                plot(x,y,'cyan', 'linewidth',1); % end of LVF shows in cyan
            end
     
     end;
      
     end
   
end
xlabel('Time [100 \mu sec]', 'fontsize', 18);
xlim ([-1.8 * 1000000, 0.7 * 1000000]);
set(gca,'fontsize',16)
ylabel('Unit number');
%saveas(gcf,'Rasterplot_distancerev1','espc');
 print('raster_quality', '-dpng', '-r300')




