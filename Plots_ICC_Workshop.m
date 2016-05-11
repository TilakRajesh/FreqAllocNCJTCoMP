clear; close all; clc
% clear;
cd LongRun1e6
allPdB = [-5:20]; R1_QoS_list = 1:0.5:8;
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
    if allPdB (iPdB) == 0 % SNR=0
        figure
        plot(R1_QoS_list,thruPut_ARQ1(:,1),'b*-');  hold on;
        plot(R1_QoS_list,thruPut_ARQ1(:,2),'mx--');
        plot(R1_QoS_list,thruPut_ARQ1(:,3),'r.--');
        plot(R1_QoS_list,thruPut_ARQ1(:,4),'k^-');
        xlabel('$R_{m,\mathrm{QoS}}$ [bps]','interpreter','latex'); %xlabel('\itR\rm_{\itm\rm,QoS} [bps]'); 
        ylabel('Long term throughput, $\eta_{1}$ [bps]','interpreter','latex'); %title(['Transmission 1, SNR = ',num2str(allPdB(iPdB)),' dB'])
%         axis tight
        ylim([0 4])
        xlim([1 6])
        legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=3/6, SR=0', 'location', 'NorthEast')
        fixfig;
        eval(['saveas(gcf,''ICC_eta_versus_R1_QoS_SNR_',num2str(allPdB(iPdB)),'_Tx1.epsc'');'])
        eval(['saveas(gcf,''ICC_eta_versus_R1_QoS_SNR_',num2str(allPdB(iPdB)),'_Tx1.fig'');'])
    end
end
%%
figure
plot(allPdB,thruPut_ARQ1_bestR_QoS(:,1),'b*-');  hold on;
plot(allPdB,thruPut_ARQ1_bestR_QoS(:,2),'mx--');
plot(allPdB,thruPut_ARQ1_bestR_QoS(:,3),'r.--');
plot(allPdB,thruPut_ARQ1_bestR_QoS(:,4),'k^-');

xlabel('$\mathrm{SNR}$ [dB]','interpreter','latex'); 
ylabel('Long term throughput, $\eta_{1}$ [bps]','interpreter','latex'); %ylabel('Long term throughput, \eta_1 [bps]'); %title(['Transmission 1'])
legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=3/6, SR=0', 'location', 'Best')
%suptitle('Slow Fading with Best R_{QoS}')
fixfig;
eval(['saveas(gcf,''ICC_eta_versus_SNR_SlowFading_Tx1_best_R_QoS.epsc'');'])
eval(['saveas(gcf,''ICC_eta_versus_SNR_SlowFading_Tx1_best_R_QoS.fig'');'])
%%
figure
subplot(211)
plot(allPdB,thruPut_ARQ1_bestR_QoS(:,1),'b*-');  hold on;
plot(allPdB,thruPut_ARQ1_bestR_QoS(:,2),'mx--');
plot(allPdB,thruPut_ARQ1_bestR_QoS(:,3),'r.--');
plot(allPdB,thruPut_ARQ1_bestR_QoS(:,4),'k^-');
text(17,2.5,'(a)');
xlabel('$\mathrm{SNR}$ [dB]','interpreter','latex'); 
ylabel('$\eta_{1}$ [bps]','interpreter','latex'); %ylabel('\eta_1 [bps]'); %title(['Transmission 1'])
legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=3/6, SR=0', 'location', 'NorthWest')
subplot(212)
plot(allPdB,thruPut_ARQ2_bestR_QoS(:,1),'b*-');  hold on;
plot(allPdB,thruPut_ARQ2_bestR_QoS(:,2),'mx--');
plot(allPdB,thruPut_ARQ2_bestR_QoS(:,3),'r.--');
plot(allPdB,thruPut_ARQ2_bestR_QoS(:,4),'k^-');
 text(17,2.5,'(b)');
xlabel('$\mathrm{SNR}$ [dB]','interpreter','latex'); 
ylabel('$\eta_{2}$ [bps]','interpreter','latex'); %ylabel('\eta_2 [bps]'); %title(['Transmission 2'])
% legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=3/6, SR=0', 'location', 'NorthWest')
%suptitle('Slow Fading with Best R_{QoS}')
fixfig;
eval(['saveas(gcf,''ICC_eta_versus_SNR_SlowFading_Tx1_Tx2_best_R_QoS.epsc'');'])
eval(['saveas(gcf,''ICC_eta_versus_SNR_SlowFading_Tx1_Tx2_best_R_QoS.fig'');'])
%% Outage Prob
% allPdB = -5:20;
% R1_QoS_list = [0.5, 1:20];
for R1qos = 1:numel(R1_QoS_list) % 1 bps
    if R1_QoS_list(R1qos) == 4 % R1_QoS = 4 bps
        for iPdB=1:numel(allPdB )
            eval(['load log_R1_R2_PdB_',num2str(allPdB (iPdB)),'QoS',num2str(R1_QoS_list(R1qos)),'.mat w1 W sample_num PdB eta eta_FF Poutage_UE Poutage_UE_FF'])
            Pout1(iPdB,:) = squeeze(Poutage_UE(:,:,1));
            Pout2(iPdB,:) = squeeze(Poutage_UE(:,:,2));
            Pout3(iPdB,:) = squeeze(Poutage_UE(:,:,3));
            Pout1_FF(iPdB,:) = squeeze(Poutage_UE_FF(:,:,1));
            Pout2_FF(iPdB,:) = squeeze(Poutage_UE_FF(:,:,2));
        end
        figure
        semilogy(allPdB,Pout1(:,1),'b*-');  hold on;
        semilogy(allPdB,Pout1(:,2),'mx--');
        semilogy(allPdB,Pout1(:,3),'r.--');
        semilogy(allPdB,Pout1(:,4),'k^-');
        xlabel('$\mathrm{SNR}$ [dB]','interpreter','latex');
        ylabel('${P}^{\mbox{outage}}_{m,1}$','interpreter','latex');
        legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=3/6, SR=0', 'location', 'best')
        axis tight
%         ylim([10^-6 10^0])
        fixfig;
        eval(['saveas(gcf,''ICC_Pout_versus_SNR_R1_QoS_',num2str(R1_QoS_list(R1qos)),'.epsc'');'])
        eval(['saveas(gcf,''ICC_Pout_versus_SNR_R1_QoS_',num2str(R1_QoS_list(R1qos)),'.fig'');'])
        figure
        subplot(211)
        semilogy(allPdB,Pout2(:,1),'b*-');  hold on;
        semilogy(allPdB,Pout2(:,2),'mx--');
        semilogy(allPdB,Pout2(:,3),'r.--');
        semilogy(allPdB,Pout2(:,4),'k^-');
        xlabel('$\mathrm{SNR}$ [dB]','interpreter','latex');
        ylabel('${P}^{\mbox{outage}}_{m,2}$','interpreter','latex');
%         ylabel('Outage Probability'); 
        axis tight
        ylim([10^-6 10^0])
        text(14.5,10^-0.7,'(a)');
        text(16,10^-0.7,'Slow');text(16,10^-1.5,'Fading')
        legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=3/6, SR=0', 'location', 'best')
        subplot(212)
        semilogy(allPdB,Pout2_FF(:,1),'b*-');  hold on;
        semilogy(allPdB,Pout2_FF(:,2),'mx--');
        semilogy(allPdB,Pout2_FF(:,3),'r.--');
        semilogy(allPdB,Pout2_FF(:,4),'k^-');
        xlabel('$\mathrm{SNR}$ [dB]','interpreter','latex'); %title(['Fast Fading ReTx 1'])
        ylabel('${P}^{\mbox{outage}}_{m,2}$','interpreter','latex');
        axis tight
        ylim([10^-6 10^0])
        text(14.5,10^-0.7,'(b)');
        text(16,10^-0.7,'Fast');text(16,10^-1.5,'Fading')
        fixfig;
        eval(['saveas(gcf,''ICC_Pout_versus_SNR_SlowFastFading_R1_QoS_',num2str(R1_QoS_list(R1qos)),'.epsc'');'])
        eval(['saveas(gcf,''ICC_Pout_versus_SNR_SlowFastFading_R1_QoS_',num2str(R1_QoS_list(R1qos)),'.fig'');'])
    end
end
