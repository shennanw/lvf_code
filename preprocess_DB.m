function [ unit_num, unit_num_nonzero, location_code, soz_code, patient_code_new] = preprocess_DB(cluster_class, ch_loc, SOZ, patient_num)

% ix1 = strfind(waveclus_out, 't_');
% ix2 = strfind(waveclus_out, '.');
% chan_num = waveclus_out(ix1+2:ix2-1); % channel number
unit_num = length(unique(cluster_class(:,1))); % number of unit number
unit_num_nonzero = unit_num~=0;

if strcmpi(ch_loc , 'REC') location_code = 1;
elseif strcmpi(ch_loc , 'LEC' ) location_code = 2;
elseif strcmpi(ch_loc,'RHIP')location_code = 3;
elseif strcmpi(ch_loc , 'LHIP') location_code = 4;
elseif strcmpi(ch_loc, 'RA')location_code = 5;
elseif strcmpi(ch_loc, 'LA') location_code = 6;
elseif strcmpi(ch_loc ,'RPHG') location_code = 7;
elseif strcmpi(ch_loc , 'LPHG') location_code = 8;
elseif strcmpi(ch_loc , 'RMH') location_code = 9;
elseif strcmpi(ch_loc , 'LMH') location_code = 10;
elseif strcmpi(ch_loc , 'ROF') location_code = 11;
elseif strcmpi(ch_loc , 'LOF') location_code = 12;
elseif strcmpi(ch_loc , 'RPH') location_code = 13;
elseif strcmpi(ch_loc , 'LPH') location_code = 14;
elseif strcmpi(ch_loc, 'RAH')location_code = 15;
elseif strcmpi(ch_loc, 'LAH') location_code = 16;
elseif strcmpi(ch_loc, 'ROT')location_code = 17;
elseif strcmpi(ch_loc, 'RSMA') location_code = 18;
elseif strcmpi(ch_loc, 'RAMY') location_code = 19;
else
     error('You need to provide a valid channel location');
end


if strcmpi(patient_num ,'428') patient_code_new = 1;
elseif strcmpi(patient_num , '429') patient_code_new = 2;
elseif strcmpi(patient_num, '439') patient_code_new = 3;
elseif strcmpi(patient_num , '460') patient_code_new = 4;
elseif strcmpi(patient_num , '461') patient_code_new = 5;
elseif strcmpi(patient_num , '462_extended') patient_code_new = 6;
elseif strcmpi(patient_num , '462') patient_code_new = 7;
elseif strcmpi(patient_num , '464') patient_code_new = 8;
elseif strcmpi(patient_num , 'TJ038_seizure1_6min_end:43:55') patient_code_new = 9;
elseif strcmpi(patient_num , 'TJ038_seizure2_12min_end:4:45:40') patient_code_new = 10;
elseif strcmpi(patient_num ,'TJ041_seizure1_6min_end:22:22:23') patient_code_new = 11;
elseif strcmpi(patient_num , 'TJ041_seizure2_end:22:52:6') patient_code_new = 12;
elseif strcmpi(patient_num , 'TJ048_seizure2_2012:9:20_end:14:6:51') patient_code_new = 13;
elseif strcmpi(patient_num , 'TJ048_seizure2_2012:9:20_end:14:15:51') patient_code_new = 14;
elseif strcmpi(patient_num , 'TJ048_seizure3_2012:9:20_end:11:43:35') patient_code_new = 15;
elseif strcmpi(patient_num , 'TJ048_seizure3_2012:9:20_end:11:46:35') patient_code_new = 16;
elseif strcmpi(patient_num , 'TJ049_seizure1_6min_end:23:41:3') patient_code_new = 17;
elseif strcmpi(patient_num , 'TJ049_seizure2_end:14:20:4') patient_code_new = 18;
else
     error('Patient name is not in the list');
end
if strcmpi(SOZ ,'Yes') soz_code = 1;
elseif strcmpi(SOZ , 'No') soz_code = 0;
else
     error('A channel should be inside or beyond SOZ');
end


end