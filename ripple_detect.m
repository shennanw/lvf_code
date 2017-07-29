% To detect the ripples before and after LVF and also fast ripples, I used
% the parameter specific for each patient. That means this code can't be
% run for all patients with this values. 
% I looked at the rtaw signal and aligned tat with bandpass data if the
% threshold was enough to detect all ripples and fast ripples I accepted
% the threshold otherwise changed that
% for each patient the data should be read from iEEG foider and dtaa base
% based on the unit we consider 
 %load('/gestalt/home/nxe022/NathanCode/MicroViewerandTesting/TJ049sz1-LVFclips/TJ049_sz1_23:38:3-23:41:3__26.mat');
inhib_unit = 87;%;66;%:105;
Fs = eeg.samp_rate;
lvf_start =  DBfinal.T_LVF{87}(1);
lvf_end = DBfinal.T_LVF{87}(2);
%inhib_ch = 3;%:109;
lfp_unfiltered=eeg.eeg_data(44,:);

ripple = [80 250]; 
RippleFilt = fir1(1000,[ripple(1) ripple(2)]/(Fs/2));
ripple_LFP = filtfilt(RippleFilt,1,lfp_unfiltered);
hilbert_ripple=hilbert(ripple_LFP); 
ripple_amplitude=abs(hilbert_ripple);
zscore_amp=zscore(ripple_amplitude);

% ripples Before LVF
rip_before_LVF = ripple_LFP(1, (1:lvf_start* Fs));

hilb_rip_before_LVF=hilbert(rip_before_LVF); 
rip_amp_before_LVF=abs(hilb_rip_before_LVF);
zscore_amp_before_LVF=zscore(rip_amp_before_LVF);
% ripples After LVF
rip_after_LVF = ripple_LFP(1,(lvf_start* Fs:lvf_end(1)* Fs));

hilb_rip_after_LVF=hilbert(rip_after_LVF); 
rip_amp_after_LVF=abs(hilb_rip_after_LVF);
zscore_amp_after_LVF=zscore(rip_amp_after_LVF);

channel = 1;
%parameters:
step_search=round(0.001*Fs);
k=0;
total_ripple_after(channel)=0;

for j=1:step_search:numel(zscore_amp_after_LVF);
    if ((k==0) && (zscore_amp_after_LVF(j)>3))
        k=1;
        start=j;
    end;
    if ((k==1) && (zscore_amp_after_LVF(j)>1.5))
    end;
    if ((k==1) && (zscore_amp_after_LVF(j)<1.5)) 
            ((j-start)*(1/Fs))
        if  ((j-start)*(1/Fs)) > 0.008
             total_ripple_after=total_ripple_after+1;
             DBfinal.total_ripple_after{inhib_unit}=total_ripple_after;
             DBfinal.ripple_time_after{inhib_unit,total_ripple_after}=[start:j];
             DBfinal.ripple_after_LVF{inhib_unit,total_ripple_after}=rip_after_LVF(start:j);
            
        end;
        k=0;  
    end; 
end;

k=0;
total_ripple_before(channel)=0;
for j=1:step_search:numel(zscore_amp_before_LVF);
    if ((k==0) && (zscore_amp_before_LVF(j)>3))
        k=1;
        start=j;
    end;
    if ((k==1) && (zscore_amp_before_LVF(j)>1.5))
    end;
    if ((k==1) && (zscore_amp_before_LVF(j)<1.5)) 
            ((j-start)*(1/Fs))
        if  ((j-start)*(1/Fs)) > 0.008
             total_ripple_before=total_ripple_before+1;
             DBfinal.total_ripple_before{inhib_unit} =total_ripple_before;
             DBfinal.ripple_time_before{inhib_unit,total_ripple_before}=[start:j];
             DBfinal.ripple_before_LVF{inhib_unit,total_ripple_before}=rip_before_LVF(start:j);
            
        end;
        k=0;  
    end; 
end;

%% Fast Ripples 
fripple = [250, 600];
frippleFilt = fir1(1000, [fripple(1) fripple(2)]/(Fs/2));
fripple_LFP = filtfilt(frippleFilt, 1, lfp_unfiltered);

hilbert_fripple=hilbert(fripple_LFP); 
fripple_amplitude=abs(hilbert_fripple);
zscore_amp_fast=zscore(fripple_amplitude);
%figure;plot((1:length( fripple_LFP(1,1:(43.72+ 20)* Fs)))/Fs, fripple_LFP(1,1:(43.72+ 20)* Fs));

% fast ripples Before LVF
frip_before_LVF = fripple_LFP(1, (1:lvf_start*Fs));

hilb_frip_before_LVF=hilbert(frip_before_LVF); 
frip_amp_before_LVF=abs(hilb_frip_before_LVF);
zscore_amp_fast_before_LVF=zscore(frip_amp_before_LVF);
% Fast ripples After LVF
frip_after_LVF = fripple_LFP(1,(lvf_start* Fs:lvf_end(1)* Fs));

hilb_frip_after_LVF=hilbert(frip_after_LVF); 
frip_amp_after_LVF=abs(hilb_frip_after_LVF);
zscore_amp_fast_after_LVF=zscore(frip_amp_after_LVF);


channel = 1;
%parameters:
step_search=round(0.001*Fs);
k=0;
total_fripple_after(channel)=0;

for j=1:step_search:numel(zscore_amp_fast_after_LVF);
    if ((k==0) && (zscore_amp_fast_after_LVF(j)>2))
        k=1;
        start=j;
    end;
    if ((k==1) && (zscore_amp_fast_after_LVF(j)>1))
    end;
    if ((k==1) && (zscore_amp_fast_after_LVF(j)<1)) 
            ((j-start)*(1/Fs))
        if  ((j-start)*(1/Fs)) > 0.008
             total_fripple_after=total_fripple_after(channel)+1;
             DBfinal.total_fripple_after{inhib_unit}=total_fripple_after;
             DBfinal.fripple_time_after{inhib_unit,total_fripple_after}=[start:j];
             DBfinal.fripple_after_LVF{inhib_unit,total_fripple_after}=frip_after_LVF(start:j);
            
        end;
       k=0;  
    end; 
end;

k=0;
total_fripple_before(channel)=0;

for j=1:step_search:numel(zscore_amp_fast_before_LVF);
    if ((k==0) && (zscore_amp_fast_before_LVF(j)>2))
        k=1;
        start=j;
    end;
    if ((k==1) && (zscore_amp_fast_before_LVF(j)>1))
    end;
    if ((k==1) && (zscore_amp_fast_before_LVF(j)<1)) 
            ((j-start)*(1/Fs))
        if  ((j-start)*(1/Fs)) > 0.008
             total_fripple_before=total_fripple_before(channel)+1;
             DBfinal.total_fripple_before{inhib_unit}=total_fripple_before;
             DBfinal.fripple_time_before{inhib_unit,total_fripple_before}=[start:j];
             DBfinal.fripple_before_LVF{inhib_unit,total_fripple_before}=frip_before_LVF(start:j);
            
        end;
       k=0;  
    end; 
end;