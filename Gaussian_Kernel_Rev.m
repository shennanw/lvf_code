
 %%Gaussian Kernel Function for spike rate

 function [DBfinal]= Gaussian_Kernel_Rev(unit_num, DBfinal)
 
y=DBfinal.Raster{unit_num};%(1:DBfinal.T_LVF{1}(2)*10000);
plot(y)
hold on

k = gausswin(50);
z=conv(double(y),k);
z=z(ceil(length(k)/2):end-floor(length(k)/2));

plot(z, '-r');
DBfinal.gaussian_50{unit_num} = z;
 end
