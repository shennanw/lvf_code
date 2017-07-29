% This code is how we proved that the SOZ for 428 is right side not left
% side as it was indicated in the documetns from UCLA
RA = load('/gestalt/home/microelectrode_data/microelectrode_seizures_2009-2014_raw/microelectrode seizures 2009-2014 raw/428/CSC1.mat');
figure;
subplot(3, 1,1)
plot((1:length(eeg.eeg_data(36,:)))/30000, eeg.eeg_data(36,:))

REC = load('/gestalt/home/microelectrode_data/microelectrode_seizures_2009-2014_raw/microelectrode seizures 2009-2014 raw/428/CSC9.mat');
subplot(3, 1,2)
plot((1:length(eeg.eeg_data(43,:)))/30000,eeg.eeg_data(43,:) )

RMH = load('/gestalt/home/microelectrode_data/microelectrode_seizures_2009-2014_raw/microelectrode seizures 2009-2014 raw/428/CSC17.mat');
subplot(3, 1,3)
plot((1:length(eeg.eeg_data(50,:)))/30000, eeg.eeg_data(50,:))


figure;
plot(eeg.eeg_data(15,:))


