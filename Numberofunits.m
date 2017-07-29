%% Number of inhibitory and excitatory in and out of SOZ
% This code is calculating number of inhibitory and excitatory units inside
% and outside of SOZ 
% If any new data added just run this code to obtain the number of each
% group of neurons in/out SOZ.
total_num = 113;
inh = [18, 20, 23, 24, 25,31,33,37, 38, 39 41,42,43, 44, 47, 58, 60, 61, 62, 63, 77,79, 82, 88, 92, 95, 100, 102:105, 108, 113];
exc = setdiff(1:total_num, inh);
ind_long = [];
   for i = 1: 113
       if DBfinal.long_unit {i}==1
           ind_long = [ind_long, i];
       end
   end
   
exc_isoz = [];
exc_osoz =[];
    exc(ind_long) =nan;
    for i = 1: length(exc)
        if (DBfinal.SOZ_code{i} ==1)&&(~isnan(exc(i)))
            exc_isoz = [exc_isoz, i];
        end
        if (DBfinal.SOZ_code{i} ==0)&&(~isnan(exc(i)))
            exc_osoz = [exc_osoz, i];
        end
    end
