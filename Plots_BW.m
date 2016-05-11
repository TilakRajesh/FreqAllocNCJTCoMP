%% Settings
clear;  close all; clc
saveFigs = 1; % 1 = save figs/epsc and 0 = don't save
cd Delay_1e6
%% Plot of diversity order versus R_QoS
R1_QoS_list = 1:7;
DivOrder = [ log10(0.005112)-log10(1.4e-5)/(-2-3), log10(0.007231)-log10(2.3e-5)/(3-9), log10(0.008317)-log10(2.2e-5)/(7.5-19), log10(0.007638)-log10(1.9e-5)/(4-13); ... % R1_QoS = 1bps, same order as the legend
            log10(0.002977)-log10(2e-6)/(3.5-10), log10(0.004925)-log10(2e-5)/(11.5-19), log10(0.007945)-log10(0.000741)/(15-20),  log10(0.004427)-log10(1.7e-5)/(9.5-18); ... % 2bps
            log10(0.002742)-log10(6e-6)/(8-14), log10(0.2866)-log10(0.027)/(13-20), log10(0.2175)-log10(0.01125)/(12.5-20), log10(0.0104)-log10(4.1e-5)/(11.5-20); ... %3bps
            log10(0.001639)-log10(3.4e-5)/(14-19.5), log10(0.9992)-log10(0.8153)/(14.5-20), log10(0.1992)-log10(0.08557)/(17.5-20), log10(0.007138)-log10(0.000301)/(15-20); ... % 4bps
            log10(0.05435)-log10(0.007961)/(15.5-20), (1-1)/(1), log10(0.5147)-log10(0.3602)/(18.5-20), log10(0.02396)-log10(0.001636)/(15.5-20); ... % 5bps
            0, 0, log10(0.9062)-log10(0.8308)/(19-20), log10(0.06455)-log10(0.007391)/(16-20); ... % 6 bps
            0, 0, 0, log10(0.1429)-log10(0.0264)/(16.5-20)]; 
figure
plot(R1_QoS_list,-DivOrder(:,1),'b*-');  hold on;
plot(R1_QoS_list,-DivOrder(:,2),'mx--');
plot(R1_QoS_list,-DivOrder(:,3),'r.--');
plot(R1_QoS_list,-DivOrder(:,4),'k^-');
xlabel('R_{QoS} [bps]'); ylabel('Diversity Order'); title(['Transmission 1'])
legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=1/2, SR=0', 'location', 'Best')
fixfig;
if saveFigs == 1
    eval(['saveas(gcf,''DivOrder_versus_R1_QoS.fig'');'])
    eval(['saveas(gcf,''DivOrder_versus_R1_QoS.epsc'');'])
end

%% GD: meeting 2013-10-11
% allPdB = -5:20; R1_QoS_list = [0.5, 1:20];
% allPdB = -5:0.5:20; R1_QoS_list = [0.5, 1:20];
allPdB = -5:20; R1_QoS_list = 1:0.5:8;
for iPdB=1:numel(allPdB )
    for qos = 1:numel(R1_QoS_list)
        eval(['load log_R1_R2_PdB_',num2str(allPdB (iPdB)),'QoS',num2str(R1_QoS_list(qos)),'.mat w1 W sample_num PdB eta eta_FF Poutage_UE Poutage_UE_FF'])
        thruPut_ARQ1(qos,:) = squeeze(eta(:,:,1));
        thruPut_ARQ2(qos,:) = squeeze(eta(:,:,2));
        thruPut_ARQ3(qos,:) = squeeze(eta(:,:,3));
        thruPut_ARQ1_FF(qos,:) = squeeze(eta_FF(:,:,1));
        thruPut_ARQ2_FF(qos,:) = squeeze(eta_FF(:,:,2));
    end
    thruPut_ARQ1_bestR_QoS(iPdB,:) = max(thruPut_ARQ1);
    thruPut_ARQ2_bestR_QoS(iPdB,:) = max(thruPut_ARQ2);
    thruPut_ARQ3_bestR_QoS(iPdB,:) = max(thruPut_ARQ3);
    thruPut_ARQ1_FF_bestR_QoS(iPdB,:) = max(thruPut_ARQ1_FF);
    thruPut_ARQ2_FF_bestR_QoS(iPdB,:) = max(thruPut_ARQ2_FF);
    
    w2 = w1;
    w3 = W - w1 - w2;
    figure
    plot(R1_QoS_list,thruPut_ARQ1(:,1),'b*-');  hold on;
    plot(R1_QoS_list,thruPut_ARQ1(:,2),'mx--');
    plot(R1_QoS_list,thruPut_ARQ1(:,3),'r.--');
    plot(R1_QoS_list,thruPut_ARQ1(:,4),'k^-');
    xlabel('\itR\rm_{QoS} [bps]'); ylabel('\eta [bps]'); title(['Transmission 1, SNR = ',num2str(allPdB(iPdB)),' dB'])
    legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=1/2, SR=0', 'location', 'Best')
    fixfig;
    axis tight
    if saveFigs == 1
        eval(['saveas(gcf,''eta_versus_R1_QoS_SNR_',num2str(allPdB(iPdB)),'.fig'');'])
        eval(['saveas(gcf,''eta_versus_R1_QoS_SNR_',num2str(allPdB(iPdB)),'.epsc'');'])
    end
end
%% Behrooz's plot,
figure
subplot(221)
plot(allPdB,thruPut_ARQ1_bestR_QoS(:,1),'b*-');  hold on;
plot(allPdB,thruPut_ARQ1_bestR_QoS(:,2),'mx--');
plot(allPdB,thruPut_ARQ1_bestR_QoS(:,3),'r.--');
plot(allPdB,thruPut_ARQ1_bestR_QoS(:,4),'k^-');
xlabel('SNR [dB]'); ylabel('\eta [bps]'); title(['Transmission 1'])
subplot(222)
plot(allPdB,thruPut_ARQ2_bestR_QoS(:,1),'b*-');  hold on;
plot(allPdB,thruPut_ARQ2_bestR_QoS(:,2),'mx--');
plot(allPdB,thruPut_ARQ2_bestR_QoS(:,3),'r.--');
plot(allPdB,thruPut_ARQ2_bestR_QoS(:,4),'k^-');
xlabel('SNR [dB]'); ylabel('\eta [bps]'); title(['ReTransmission 1'])
subplot(223)
plot(allPdB,thruPut_ARQ3_bestR_QoS(:,1),'b*-');  hold on;
plot(allPdB,thruPut_ARQ3_bestR_QoS(:,2),'mx--');
plot(allPdB,thruPut_ARQ3_bestR_QoS(:,3),'r.--');
plot(allPdB,thruPut_ARQ3_bestR_QoS(:,4),'k^-');
xlabel('SNR [dB]'); ylabel('\eta [bps]'); title(['ReTransmission 2'])
subplot(224)
plot(allPdB,nan*thruPut_ARQ1_bestR_QoS(:,1),'b*-');  hold on;
plot(allPdB,nan*thruPut_ARQ1_bestR_QoS(:,2),'mx--');
plot(allPdB,nan*thruPut_ARQ1_bestR_QoS(:,3),'r.--');
plot(allPdB,nan*thruPut_ARQ1_bestR_QoS(:,4),'k^-');
axis off
legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=1/2, SR=0', 'location', 'Best')
suptitle('Slow Fading with Best R_{QoS}')
if saveFigs == 1
    eval(['saveas(gcf,''eta_versus_SNR_SlowFading.fig'');'])
    eval(['saveas(gcf,''eta_versus_SNR_SlowFading.epsc'');'])
end
% Fast Fading
figure
subplot(221)
plot(allPdB,thruPut_ARQ1_FF_bestR_QoS(:,1),'b*-');  hold on;
plot(allPdB,thruPut_ARQ1_FF_bestR_QoS(:,2),'mx--');
plot(allPdB,thruPut_ARQ1_FF_bestR_QoS(:,3),'r.--');
plot(allPdB,thruPut_ARQ1_FF_bestR_QoS(:,4),'k^-');
xlabel('SNR [dB]'); ylabel('\eta [bps]'); title(['Transmission 1'])
subplot(222)
plot(allPdB,thruPut_ARQ2_FF_bestR_QoS(:,1),'b*-');  hold on;
plot(allPdB,thruPut_ARQ2_FF_bestR_QoS(:,2),'mx--');
plot(allPdB,thruPut_ARQ2_FF_bestR_QoS(:,3),'r.--');
plot(allPdB,thruPut_ARQ2_FF_bestR_QoS(:,4),'k^-');
% legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=1/2, SR=0', 'location', 'Best')
xlabel('SNR [dB]'); ylabel('\eta [bps]'); title(['ReTransmission 1'])
% subplot(224)
% plot(allPdB,nan*thruPut_ARQ1_bestR_QoS(:,1),'b*-');  hold on;
% plot(allPdB,nan*thruPut_ARQ1_bestR_QoS(:,2),'mx--');
% plot(allPdB,nan*thruPut_ARQ1_bestR_QoS(:,3),'r.--');
% plot(allPdB,nan*thruPut_ARQ1_bestR_QoS(:,4),'k^-');
% axis off

suptitle('Fast Fading with Best R_{QoS}')
if saveFigs == 1
    eval(['saveas(gcf,''eta_versus_SNR_FastFading.fig'');'])
    eval(['saveas(gcf,''eta_versus_SNR_FastFading.epsc'');'])
end
%% Outage Prob
% allPdB = -5:20;
% R1_QoS_list = [0.5, 1:20];
for R1qos = 1:numel(R1_QoS_list) % 1 bps
    for iPdB=1:numel(allPdB )
        eval(['load log_R1_R2_PdB_',num2str(allPdB (iPdB)),'QoS',num2str(R1_QoS_list(R1qos)),'.mat w1 W sample_num PdB eta eta_FF Poutage_UE Poutage_UE_FF'])
        Pout1(iPdB,:) = squeeze(Poutage_UE(:,:,1));
        Pout2(iPdB,:) = squeeze(Poutage_UE(:,:,2));
        Pout3(iPdB,:) = squeeze(Poutage_UE(:,:,3));
        Pout1_FF(iPdB,:) = squeeze(Poutage_UE_FF(:,:,1));
        Pout2_FF(iPdB,:) = squeeze(Poutage_UE_FF(:,:,2));
    end
    figure
    subplot(221)
    semilogy(allPdB,Pout1(:,1),'b*-');  hold on;
    semilogy(allPdB,Pout1(:,2),'mx--');
    semilogy(allPdB,Pout1(:,3),'r.--');
    semilogy(allPdB,Pout1(:,4),'k^-');
    xlabel('SNR [dB]'); ylabel('Outage Probability'); title(['Transmission 1'])
    subplot(222)
    semilogy(allPdB,Pout2(:,1),'b*-');  hold on;
    semilogy(allPdB,Pout2(:,2),'mx--');
    semilogy(allPdB,Pout2(:,3),'r.--');
    semilogy(allPdB,Pout2(:,4),'k^-');
    xlabel('SNR [dB]'); ylabel('Outage Probability '); title(['ReTransmission 1'])
    subplot(223)
    semilogy(allPdB,Pout3(:,1),'b*-');  hold on;
    semilogy(allPdB,Pout3(:,2),'mx--');
    semilogy(allPdB,Pout3(:,3),'r.--');
    semilogy(allPdB,Pout3(:,4),'k^-');
    xlabel('SNR [dB]'); ylabel('Outage Probability '); title(['ReTransmission 2'])
    subplot(224)
    plot(allPdB,nan*Pout1(:,1),'b*-');  hold on;
    plot(allPdB,nan*Pout1(:,2),'mx--');
    plot(allPdB,nan*Pout1(:,3),'r.--');
    plot(allPdB,nan*Pout1(:,4),'k^-');
    axis off
    legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=1/2, SR=0', 'location', 'Best')
    suptitle(['Slow Fading with R_{QoS}=',num2str(R1_QoS_list(R1qos)),' [bps]'])
    if saveFigs == 1
        eval(['saveas(gcf,''Pout_versus_SNR_SlowFading_R1_QoS_',num2str(R1_QoS_list(R1qos)),'.fig'');'])
        eval(['saveas(gcf,''Pout_versus_SNR_SlowFading_R1_QoS_',num2str(R1_QoS_list(R1qos)),'.epsc'');'])
    end
    figure
    subplot(221)
    semilogy(allPdB,Pout1_FF(:,1),'b*-');  hold on;
    semilogy(allPdB,Pout1_FF(:,2),'mx--');
    semilogy(allPdB,Pout1_FF(:,3),'r.--');
    semilogy(allPdB,Pout1_FF(:,4),'k^-');
    xlabel('SNR [dB]'); ylabel('Outage Probability'); title(['Transmission 1'])
    subplot(222)
    semilogy(allPdB,Pout2_FF(:,1),'b*-');  hold on;
    semilogy(allPdB,Pout2_FF(:,2),'mx--');
    semilogy(allPdB,Pout2_FF(:,3),'r.--');
    semilogy(allPdB,Pout2_FF(:,4),'k^-');
    xlabel('SNR [dB]'); ylabel('Outage Probability'); title(['ReTransmission 1'])
    subplot(224)
    plot(allPdB,nan*Pout2_FF(:,1),'b*-');  hold on;
    plot(allPdB,nan*Pout2_FF(:,2),'mx--');
    plot(allPdB,nan*Pout2_FF(:,3),'r.--');
    plot(allPdB,nan*Pout2_FF(:,4),'k^-');
    axis off
    legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=1/2, SR=0', 'location', 'Best')
    suptitle(['Fast Fading with R_{QoS}=',num2str(R1_QoS_list(R1qos)),'[bps]'])
    if saveFigs == 1
        eval(['saveas(gcf,''Pout_versus_SNR_FastFading_R1_QoS_',num2str(R1_QoS_list(R1qos)),'.fig'');'])
        eval(['saveas(gcf,''Pout_versus_SNR_FastFading_R1_QoS_',num2str(R1_QoS_list(R1qos)),'.epsc'');'])
    end
end
%%