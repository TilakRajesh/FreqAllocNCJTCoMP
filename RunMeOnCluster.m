function RunMeOnCluster(PdB, R1_QoS, R2_QoS, R1_QoS_delay_range)

%% This is the scenario
W = 1; % Total bandwidth and w1 + w2 + w3 = W
sample_num=1e1%1e6%50000
w1 = [0, 1/6, 2/6, 1/2]; 
%%
eta = zeros(numel(PdB),numel(w1),3);% 3 is the number transmissions + number of retransmissions (1+1)
eta_FF = zeros(numel(PdB),numel(w1),2);% 3 is the number transmissions + number of retransmissions (1+1)
Poutage_UE = zeros(numel(PdB),numel(w1),3);% 3 is the number transmissions + number of retransmissions (1+1)
Poutage_UE_FF = zeros(numel(PdB),numel(w1),2);% 3 is the number transmissions + number of retransmissions (1+1)
delay = zeros(numel(PdB),numel(w1),3);% 3 is the number transmissions + number of retransmissions (1+1)
delay_FF = zeros(numel(PdB),numel(w1),2);% 3 is the number transmissions + number of retransmissions (1+1)
Pout = [10^-5, 10^-4, 10^-3, 10^-2, 10^-1];
DD2 = zeros(numel(PdB),numel(w1),numel(R1_QoS_delay_range));
DD2_FF = zeros(numel(PdB),numel(w1),numel(R1_QoS_delay_range));
Pout2 = zeros(numel(PdB),numel(w1),numel(R1_QoS_delay_range));
Pout2_FF = zeros(numel(PdB),numel(w1),numel(R1_QoS_delay_range));
%%
for w1Ind = 1:numel(w1)
    w2 = w1(w1Ind);
    w3 = W - w1(w1Ind) - w2;
    for iPdB = 1:numel(PdB)
        [eta_T,eta_T_FF, Poutage_UE_T, Poutage_UE_FF_T, delay_T, delay_FF_T, DD2_T, DD2_FF_T, Pout2_T, Pout2_T_FF ] = Simulate_BWbehrooz(w1Ind, w1(w1Ind), w2, w3, sample_num, PdB(iPdB), R1_QoS, R2_QoS, Pout, R1_QoS_delay_range);
        eta(iPdB,w1Ind,:) = eta_T;
        eta_FF(iPdB,w1Ind,:) = eta_T_FF;
        Poutage_UE(iPdB,w1Ind,:) = Poutage_UE_T;
        Poutage_UE_FF(iPdB,w1Ind,:) = Poutage_UE_FF_T;
        delay(iPdB,w1Ind,:) = delay_T;
        delay_FF(iPdB,w1Ind,:) = delay_FF_T;
        DD2(iPdB,w1Ind,:) = DD2_T;
        DD2_FF(iPdB,w1Ind,:) = DD2_FF_T;
        Pout2(iPdB,w1Ind,:) = Pout2_T;
        Pout2_FF(iPdB,w1Ind,:) = Pout2_T_FF;
        eval(['save delay_Pout/log_R1_R2_PdB_',num2str(PdB),'QoS',num2str(R1_QoS),'.mat w1 W sample_num PdB eta eta_FF R1_QoS R2_QoS Poutage_UE Poutage_UE_FF delay delay_FF DD2 DD2_FF Pout R1_QoS_delay_range Pout2 Pout2_FF'])
    end
end