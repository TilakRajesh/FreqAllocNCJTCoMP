function [eta_best,eta_best_FF, Poutage_UE, Poutage_UE_FF, delay, delay_FF, DD2, DD2_FF, Pout2_T, Pout2_T_FF ] ...
    = Simulate_BWbehrooz(w1Ind, w1, w2, w3, sample_num, PdB, R1_QoS, R2_QoS, Pout, R1_QoS_delay_range)
randn('state',sum(100*clock));
rand('twister',sum(100*clock));
P = (10^(PdB/10)); % Total Power
N0 = 1;

R_UE1_1 = zeros(sample_num,1);
R_UE2_2 = zeros(sample_num,1);
R_UE1_3 = zeros(sample_num,1);
R_UE2_3 = zeros(sample_num,1);
R_UE1_1_1FF = zeros(sample_num,1);
R_UE2_2_1FF = zeros(sample_num,1);
R_UE1_3_1FF = zeros(sample_num,1);
R_UE2_3_1FF = zeros(sample_num,1);
R_UE1_1_2FF = zeros(sample_num,1);
R_UE2_2_2FF = zeros(sample_num,1);
R_UE1_3_2FF = zeros(sample_num,1);
R_UE2_3_2FF = zeros(sample_num,1);
parfor k=1:sample_num
    % for k=1:sample_num
    switch w1Ind
        case 1 % w1 = 0, w3 = 1, so 12 IID
            H = sqrt(0.5)*randn(12,2) + 1j*sqrt(0.5)*randn(12,2); % number of channels x number of BSs
            [R_UE1_3(k), R_UE2_3(k)] = CalculateRate_DR0_SR1(H,P,w3, N0);
            %% Fast fading case
            % 1st Retransmission
            H_1FF = sqrt(0.5)*randn(12,2) + 1j*sqrt(0.5)*randn(12,2);
            [R_UE1_3_1FF(k), R_UE2_3_1FF(k)] = CalculateRate_DR0_SR1(H_1FF,P,w3, N0);
            % 2nd Retransmission
            H_2FF = sqrt(0.5)*randn(12,2) + 1j*sqrt(0.5)*randn(12,2);
            [R_UE1_3_2FF(k), R_UE2_3_2FF(k)] = CalculateRate_DR0_SR1(H_2FF,P,w3, N0);
        case 2 % 10 links: w1 = 1/6, w3=4/6
            H = sqrt(0.5)*randn(10,2) + 1j*sqrt(0.5)*randn(10,2);
            [R_UE1_1(k), R_UE2_2(k), R_UE1_3(k), R_UE2_3(k)] = CalculateRate_DR16_SR46(H,P, w1, w2, w3, N0);
            %% Fast fading case
            % 1st Retransmission
            H_1FF = sqrt(0.5)*randn(10,2) + 1j*sqrt(0.5)*randn(10,2);
            [R_UE1_1_1FF(k), R_UE2_2_1FF(k), R_UE1_3_1FF(k), R_UE2_3_1FF(k)] = CalculateRate_DR16_SR46(H_1FF,P, w1, w2, w3, N0);
            % 2nd Retransmission
            H_2FF = sqrt(0.5)*randn(10,2) + 1j*sqrt(0.5)*randn(10,2);
            [R_UE1_1_2FF(k), R_UE2_2_2FF(k), R_UE1_3_2FF(k), R_UE2_3_2FF(k)] = CalculateRate_DR16_SR46(H_2FF,P, w1, w2, w3, N0);
        case 3 % 8 links: : w1 = 2/6, w3=2/6
            H = sqrt(0.5)*randn(8,2) + 1j*sqrt(0.5)*randn(8,2);
            [R_UE1_1(k), R_UE2_2(k), R_UE1_3(k), R_UE2_3(k)] = CalculateRate_DR26_SR26(H,P, w1, w2, w3, N0);
            %% Fast fading case
            % 1st Retransmission
            H_1FF = sqrt(0.5)*randn(8,2) + 1j*sqrt(0.5)*randn(8,2);
            [R_UE1_1_1FF(k), R_UE2_2_1FF(k), R_UE1_3_1FF(k), R_UE2_3_1FF(k)] = CalculateRate_DR26_SR26(H_1FF,P, w1, w2, w3, N0);
            % 2nd Retransmission
            H_2FF = sqrt(0.5)*randn(8,2) + 1j*sqrt(0.5)*randn(8,2);
            [R_UE1_1_2FF(k), R_UE2_2_2FF(k), R_UE1_3_2FF(k), R_UE2_3_2FF(k)] = CalculateRate_DR26_SR26(H_2FF,P, w1, w2, w3, N0);
        case 4 % 6 links: : w1 = 3/6, w3=0
            H = sqrt(0.5)*randn(6,2) + 1j*sqrt(0.5)*randn(6,2);
            [R_UE1_1(k), R_UE2_2(k)] = CalculateRate_DR36_SR0(H,P, w1, w2, w3, N0);
            %% Fast fading case
            % 1st Retransmission
            H_1FF = sqrt(0.5)*randn(6,2) + 1j*sqrt(0.5)*randn(6,2);
            [R_UE1_1_1FF(k), R_UE2_2_1FF(k)] = CalculateRate_DR36_SR0(H_1FF,P, w1, w2, w3, N0);
            % 2nd Retransmission
            H_2FF = sqrt(0.5)*randn(6,2) + 1j*sqrt(0.5)*randn(6,2);
            [R_UE1_1_2FF(k), R_UE2_2_2FF(k)] = CalculateRate_DR36_SR0(H_2FF,P, w1, w2, w3, N0);
    end
end
%% Original scenario: Slow Fading
R1_T = R_UE1_1 + R_UE1_3;
R2_T = R_UE2_2 + R_UE2_3;
prob_R1_temp = mean(R1_T >= R1_QoS);
prob_R2_temp = mean(R2_T >= R2_QoS);
eta1 = (R1_QoS * prob_R1_temp) +  (R2_QoS * prob_R2_temp);
L = 1;
% T+1 = 1 % Delay is evaluated only for one UE
delay1 = 1;
% T+1 = 2
delay2 = (L*mean(R1_T >= R1_QoS)) + (1+1)*L*mean(R1_T < R1_QoS);
prob_R1_temp = mean(((R1_QoS/2) <= R1_T) & (R1_T <= R1_QoS));
prob_R2_temp = mean(((R2_QoS/2) <= R2_T) & (R2_T <= R2_QoS));
eta2 = (((R1_QoS/2) * prob_R1_temp) + ((R2_QoS/2) * prob_R2_temp));
% T+1 = 3
delay3 = (L*mean(R1_T >= R1_QoS)) + (1+1)*L*mean(((R1_QoS/2) <= R1_T) & (R1_T <= R1_QoS)) + (2+1)*L*mean(R1_T < (R1_QoS/2));

prob_R1_temp = mean(((R1_QoS/3) <= R1_T) & (R1_T <= (R1_QoS/2)));
prob_R2_temp = mean(((R2_QoS/3) <= R2_T) & (R2_T <= (R2_QoS/2)));
eta3 = (((R1_QoS/3) * prob_R1_temp) + ((R2_QoS/3) * prob_R2_temp));
eta2 = eta1 + eta2;
eta3 = eta2 + eta3;
eta_best = [eta1; eta2; eta3];
Poutage_UE = [mean(R1_QoS > R1_T); mean((R1_QoS/2) > R1_T); mean((R1_QoS/3) > R1_T)]; % Per UE

%% Fast Fading with only one retransmission
R1_T_FF = R_UE1_1_1FF + R_UE1_3_1FF;
R2_T_FF = R_UE2_2_1FF + R_UE2_3_1FF;
AAAAR1_T = R_UE1_1_2FF + R_UE1_3_2FF + R1_T_FF;
AAAAR2_T = R_UE2_2_2FF + R_UE2_3_2FF + R2_T_FF;
prob_R1_temp = mean((R1_T_FF) >= R1_QoS);
prob_R2_temp = mean((R2_T_FF) >= R2_QoS);
eta1_FF = (R1_QoS * prob_R1_temp) +  (R2_QoS * prob_R2_temp);
prob_R1_temp = mean(((R1_QoS) <= (AAAAR1_T)) & ((R1_T_FF) <= R1_QoS));
prob_R2_temp = mean(((R2_QoS) <= (AAAAR2_T)) & ((R2_T_FF) <= R2_QoS));
eta2_FF = (((R1_QoS/2) * prob_R1_temp) + ((R2_QoS/2) * prob_R2_temp));

eta2_FF = eta1_FF + eta2_FF;
eta_best_FF = [eta1_FF; eta2_FF];
Poutage_UE_FF = [mean(R1_QoS > R1_T_FF); mean((R1_QoS/2) > R1_T_FF); ]; % Per UE
% Delay
% T+1 = 1 % Delay is evaluated only for one UE
delay1_FF = 1;
% T+1 = 2
delay2_FF = (L*mean(R1_T_FF >= R1_QoS)) + (1+1)*L*mean(AAAAR1_T < R1_QoS);
% % T+1 = 3 % Not yet calculated for 2 retransmissions
% delay3_FF = (L*mean(R1_T_FF >= R1_QoS)) + (1+1)*L*mean(((R1_QoS/2) <= AAAAR1_T) & (AAAAR1_T <= R1_QoS)) + (2+1)*L*mean(R1_T_FF < (R1_QoS/2));
%% Compute the expected delay
delay = [delay1;delay2;delay3];
delay_FF = [delay1_FF;delay2_FF];
%% For delay versus Pout for T=1, i.e., T+1 = 2

% R1_Qos_delay = zeros(numel(Pout),3);
% R1_Qos_delay_FF = zeros(numel(Pout),2);
% DD2 = zeros(numel(Pout),1);
% DD2_FF = zeros(numel(Pout),1);
% % Pout1_T = zeros(numel(R1_QoS_delay_range),1);
% Pout2_T = zeros(numel(R1_QoS_delay_range),1);
% % Pout3_T = zeros(numel(R1_QoS_delay_range),1);
% % Pout1_T_FF = zeros(numel(R1_QoS_delay_range),1);
% Pout2_T_FF = zeros(numel(R1_QoS_delay_range),1);
% for r1Index = 1:numel(R1_QoS_delay_range)
%     %         Pout1_T(r1Index) = mean(R1_T < R1_QoS_delay_range(r1Index));
%     Pout2_T(r1Index) = mean(R1_T < (R1_QoS_delay_range(r1Index)/2));
%     %         Pout3_T(r1Index) = mean(R1_T < (R1_QoS_delay_range(r1Index)/3));
%     %         Pout1_T_FF(r1Index) = mean(R1_T_FF < R1_QoS_delay_range(r1Index));
%     Pout2_T_FF(r1Index) = mean(AAAAR1_T < (R1_QoS_delay_range(r1Index)/2));
% end
% for iPout = 1:numel(Pout)
%     %     [c,i]=min((Pout1_T - Pout(iPout)).^2); % find the R_QoS that is closest to the outage prob
%     %     R1_Qos_delay(iPout,1) = R1_QoS_delay_range(i);
%     [c,i]=min((Pout2_T - Pout(iPout)).^2); % Finding with the best R_QoS, gives a misconception that we get better rate with delay
%     R1_Qos_delay(iPout,2) = R1_QoS_delay_range(i);
%     DD2(iPout) = (L*mean(R1_T >= R1_Qos_delay(iPout,2))) + (1+1)*L*mean(R1_T < R1_Qos_delay(iPout,2));
%     %     [c,i]=min((Pout3_T - Pout(iPout)).^2);
%     %     R1_Qos_delay(iPout,3) = R1_QoS_delay_range(i);
%     %     [c,i]=min((Pout1_T_FF - Pout(iPout)).^2); % find the R_QoS that is closest to the outage prob
%     %     R1_Qos_delay_FF(iPout,1) = R1_QoS_delay_range(i);
%     [c,i]=min((Pout2_T_FF - Pout(iPout)).^2);
%     R1_Qos_delay_FF(iPout,2) = R1_QoS_delay_range(i);
%     DD2_FF(iPout) = (L*mean(R1_T_FF >= R1_Qos_delay_FF(iPout,2))) + (1+1)*L*mean(AAAAR1_T < R1_Qos_delay_FF(iPout,2));
% end
%% Just sweep the whole set of values for T=1 i.e., T+1=2, to plot delay versus R_QoS and Pout versus R_QoS
DD2 = zeros(numel(R1_QoS_delay_range),1);
DD2_FF = zeros(numel(R1_QoS_delay_range),1);
Pout2_T = zeros(numel(R1_QoS_delay_range),1);
Pout2_T_FF = zeros(numel(R1_QoS_delay_range),1);
L=1;
parfor r1Index = 1:numel(R1_QoS_delay_range)
    Pout2_T(r1Index) = mean(R1_T < (R1_QoS_delay_range(r1Index)/2));
    Pout2_T_FF(r1Index) = mean(AAAAR1_T < (R1_QoS_delay_range(r1Index)/2));
    DD2(r1Index) = (L*mean(R1_T >= R1_QoS_delay_range(r1Index))) + (1+1)*L*mean(R1_T < R1_QoS_delay_range(r1Index));
    DD2_FF(r1Index) = (L*mean(R1_T_FF >= R1_QoS_delay_range(r1Index))) + (1+1)*L*mean(AAAAR1_T < R1_QoS_delay_range(r1Index));
end

end

