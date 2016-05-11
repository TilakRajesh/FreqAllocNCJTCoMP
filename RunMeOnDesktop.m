clear; close all; clc
% matlabpool close force
% if (exist('local_scheduler_data','dir') == 0)
%     mkdir local_scheduler_data
% end
% sched=findResource('scheduler','type','local');
% sched.DataLocation = strcat(pwd,'/local_scheduler_data');
% matlabpool open local
%%
tic
allPdB = 10%-5:20;
R1_QoS_list = 0:0.1:4 % 1:0.5:20;
for qos = 1:numel(R1_QoS_list)
    R1_QoS = R1_QoS_list(qos);
    R2_QoS = R1_QoS;
    for iPdB = 1:numel(allPdB)
        RunMeOnCluster(allPdB(iPdB), R1_QoS, R2_QoS,R1_QoS_list);
    end
end
toc