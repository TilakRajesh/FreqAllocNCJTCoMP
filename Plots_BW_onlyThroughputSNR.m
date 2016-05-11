%% Settings
clear;  close all; clc
cd Delay_1e6
R1_QoS_list = 8;
for qos = 1:numel(R1_QoS_list)
    R1_QoS = R1_QoS_list(qos);
    allPdB = -5:10;
    % thruPut [PdB, size(w1)]
    for iPdB=1:numel(allPdB )
        eval(['load log_R1_R2_PdB_',num2str(allPdB (iPdB)),'QoS',num2str(R1_QoS),'.mat w1 W sample_num PdB eta'])
        thruPut_ARQ1(iPdB,:) = squeeze(eta(:,:,1));
        thruPut_ARQ2(iPdB,:) = squeeze(eta(:,:,2));
        thruPut_ARQ3(iPdB,:) = squeeze(eta(:,:,3));
    end
    w2 = w1;
    w3 = W - w1 - w2;
    figure
    subplot(221)
    plot(allPdB,thruPut_ARQ1(:,1),'b-');  hold on;
    plot(allPdB,thruPut_ARQ1(:,2),'g-');
    plot(allPdB,thruPut_ARQ1(:,3),'r-');
    plot(allPdB,thruPut_ARQ1(:,4),'k-');
    xlabel('SNR [dB]'); ylabel('\eta [bps]'); title('Transmission 1')
    subplot(222)
    plot(allPdB,thruPut_ARQ2(:,1),'b-');  hold on;
    plot(allPdB,thruPut_ARQ2(:,2),'g-');
    plot(allPdB,thruPut_ARQ2(:,3),'r-');
    plot(allPdB,thruPut_ARQ2(:,4),'k-');
    xlabel('SNR [dB]'); ylabel('\eta [bps]'); title('Retransmission 1')
    subplot(223)
    plot(allPdB,thruPut_ARQ3(:,1),'b-');  hold on;
    plot(allPdB,thruPut_ARQ3(:,2),'g-');
    plot(allPdB,thruPut_ARQ3(:,3),'r-');
    plot(allPdB,thruPut_ARQ3(:,4),'k-');
    xlabel('SNR [dB]'); ylabel('\eta [bps]'); title('Retransmission 2')
    subplot(224);   
    plot(allPdB,nan*thruPut_ARQ3(:,1),'b-');  hold on;
    plot(allPdB,nan*thruPut_ARQ3(:,2),'g-');
    plot(allPdB,nan*thruPut_ARQ3(:,3),'r-');
    plot(allPdB,nan*thruPut_ARQ3(:,4),'k-');
    axis off
    legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=1/2, SR=0', 'location', 'Best')
    suptitle(['R_1_{,QoS} = ',num2str(R1_QoS),' bps']);
    eval(['saveas(gcf,''eta_versus_SNR_R1_QoS_',num2str(R1_QoS),'.fig'');'])
    eval(['saveas(gcf,''EPS_Plots\eta_versus_SNR_R1_QoS_',num2str(R1_QoS),'.epsc'');'])
    
    %%
    figure
    subplot(221)
    plot(w3,thruPut_ARQ1'); hold on
    xlabel('Shared Resource (SR)'); ylabel('\eta'); title('Transmission 1')
    subplot(222)
    plot(w3,thruPut_ARQ2'); hold on
    xlabel('Shared Resource (SR)'); ylabel('\eta'); title('Retransmission 1')
    subplot(223)
    plot(w3,thruPut_ARQ3'); hold on
    xlabel('Shared Resource (SR)'); ylabel('\eta'); title('Retransmission 2')
    subplot(224); plot(nan*thruPut_ARQ3'); axis off
    legend('-5 dB', ...
        '-4 dB', ...
        '-3 dB', ...
        '-2 dB', ...
        '-1 dB', ...
        '0 dB', ...
        '1 dB', ...
        '2 dB', ...
        '3 dB', ...
        '4 dB', ...
        '5 dB', ...
        '6 dB', ...
        '7 dB', ...
        '8 dB', ...
        '9 dB', ...
        '10 dB', ...
        'location','Best');
    suptitle(['R_1_{,QoS} = ',num2str(R1_QoS),' bps']);
    %     suptitle('\eta = R_{1,QoS} * Prob(R_1 \geq R_{1,QoS}) +  R_{2,QoS} * Prob(R_2 \geq R_{2,QoS})')
    eval(['saveas(gcf,''eta_versus_SharedResource_w3_R1_QoS_',num2str(R1_QoS),'.fig'');'])
    eval(['saveas(gcf,''EPS_Plots\eta_versus_SharedResource_w3_R1_QoS_',num2str(R1_QoS),'.epsc'');'])
    figure
    subplot(221)
    surf(w3,allPdB,thruPut_ARQ1)
    ylabel('SNR'); xlabel('Shared Resource (SR)'); zlabel('\eta'); title('Trans 1')
    subplot(222)
    surf(w3,allPdB,thruPut_ARQ2); title('Retrans 2')
    subplot(223)
    surf(w3,allPdB,thruPut_ARQ3); title('Retrans 3')
    suptitle(['R_1_{,QoS} = ',num2str(R1_QoS),' bps']);
    %     suptitle('\eta = R_{1,QoS} * Prob(R_1 \geq R_{1,QoS}) +  R_{2,QoS} * Prob(R_2 \geq R_{2,QoS})')
    eval(['saveas(gcf,''surface_eta_versus_w3_versus_SNR_R1_QoS_',num2str(R1_QoS),'.fig'');'])
    eval(['saveas(gcf,''EPS_Plots\surface_eta_versus_w3_versus_SNR_R1_QoS_',num2str(R1_QoS),'.epsc'');'])
end
%%
% h1 = figure; suptitle('Retrans 1'); hold on
% h2 = figure; suptitle('Retrans 2'); hold on
% h3 = figure; suptitle('Retrans 3'); hold on
% for iPdB = 1:numel(allPdB)
%     figure(h1);
%     subplot(4,4,iPdB)
%     plot(w3,squeeze(optPwr_ARQ1(iPdB,:,:)),'-')
%     title(['P=',num2str(allPdB(iPdB)),'dB'])
%     figure(h2);
%     subplot(4,4,iPdB)
%     plot(w3,squeeze(optPwr_ARQ2(iPdB,:,:)),'-')
%     title(['P=',num2str(allPdB(iPdB)),'dB'])
%     figure(h3);
%     subplot(4,4,iPdB)
%     plot(w3,squeeze(optPwr_ARQ3(iPdB,:,:)),'-')
%     title(['P=',num2str(allPdB(iPdB)),'dB'])
% end
% xlabel('Shared Resource, w_3')
% ylabel('Optimal power allocation')
% legend('P1:DR:UE1','P2:DR:UE2','P3:SR:UE1','P4:SR:UE2','location','best')
% eval(['saveas(h1,''OptPower_versus_SharedResource_PdB_',num2str(allPdB(iPdB)),'_ReTrans1.fig'');'])
% eval(['saveas(h2,''OptPower_versus_SharedResource_PdB_',num2str(allPdB(iPdB)),'_ReTrans2.fig'');'])
% eval(['saveas(h3,''OptPower_versus_SharedResource_PdB_',num2str(allPdB(iPdB)),'_ReTrans3.fig'');'])
%%
% K=2; N0 = 1; s2=1/2; % sigma^2 = 1/2
% M = K;
% DR = zeros(numel(PdB),numel(w1));
% SR = zeros(numel(PdB),numel(w1));
% P = (10.^(PdB/10));
% for iw1 = 1:numel(w1)
%     for iP = 1:numel(P)
%         DR(iP,iw1) = w1(iw1)*log2(1+(P(iP)/w1(iw1)/N0)*K*2*s2);
%         SR(iP,iw1) = ...
%             w3(iw1)*log2(N0*w3(iw1)/P(iP)) ...
%             + w3(iw1)*log2(1+((P(iP)/(N0*w3(iw1)))*M*K*2*s2)) ...
%             + w3(iw1)*(2*(psi(1) + log(2) - 2*log(K*(M-1))))/log(4) ...
%             - w3(iw1)*log2(1+(N0*w3(iw1)/P(iP))) ...
%             + (N0*w3(iw1)/(P(iP) + N0*w3(iw1)))*log2(exp(1))*(2*s2*K*(M-1) - 1);
%
%     end
% end
% ER = DR + SR;
%%
% figure
% plot(PdB,R1(:,(w1 == w1(1))),'-b'); hold on;
% plot(PdB,R1(:,(w1==0.1)),'--b');
% plot(PdB,R1(:,(w1==0.2)),':b');
% plot(PdB,R1(:,(w1==0.3)),'-.b');
% plot(PdB,R1(:,(w1==0.4)),'-r');
% plot(PdB,R1(:,(w1 == w1(end))),'--r');
%
% xlabel('SNR [dB]'); ylabel('Ergodic Capacity [bps]'); title('Rate of UE_1 or UE_2, iid channels (Shannon (Ergodic) Capacity)')
% % legend('w1=0.01,    w3=0.99','w1=0.1, w3=0.8','w1=0.2, w3=0.6','w1=0.3, w3=0.4','w1=0.4, w3=0.2','w1=0.49, w3=0.01', 'location', 'best')
% legend('w1=0, w3=1','w1=0.1, w3=0.8','w1=0.2, w3=0.6','w1=0.3, w3=0.4','w1=0.4, w3=0.2','w1=0.5, w3=0', 'location', 'best')
% eval(['saveas(gcf,''ErgodicRate_versus_SNR.fig'');'])
%
% %% Theoretical
% % figure
% % plot(PdB,R1(:,(w1==0.01)),'-b'); hold on;
% % plot(PdB,R1(:,(w1==0.1)),'--b');
% % plot(PdB,R1(:,(w1==0.2)),':b');
% % plot(PdB,R1(:,(w1==0.3)),'-.b');
% % plot(PdB,R1(:,(w1==0.4)),'-r');
% % plot(PdB,R1(:,(w1==0.49)),'--r');
% % plot(PdB,ER(:,(w1==0.01)),'-ok');
% % plot(PdB,ER(:,(w1==0.1)),'--ok');
% % plot(PdB,ER(:,(w1==0.2)),'o:k');
% % plot(PdB,ER(:,(w1==0.3)),'-.ok');
% % plot(PdB,ER(:,(w1==0.4)),'-ok');
% % plot(PdB,ER(:,(w1==0.49)),'--ok');
% % xlabel('SNR [dB]'); ylabel('Ergodic Capacity [bps]'); title('With theoretical curves in "o"')
% % legend('w1=0.01,    w3=0.99','w1=0.1, w3=0.8','w1=0.2, w3=0.6','w1=0.3, w3=0.4','w1=0.4, w3=0.2','w1=0.49, w3=0.01', ...
% %     'Theo. w1=0.01,    w3=0.99','Theo. w1=0.1, w3=0.8','Theo. w1=0.2, w3=0.6','Theo. w1=0.3, w3=0.4','Theo. w1=0.4, w3=0.2','Theo. w1=0.49, w3=0.01', ...
% %     'location', 'best')
% % eval(['saveas(gcf,''ErgodicRateTheo_versus_SNR.fig'');'])
%
% %%
% figure
% semilogy(PdB,Prob_R1(:,(w1==w1(1))),'-b'); hold on;
% semilogy(PdB,Prob_R1(:,(w1==0.1)),'--b');
% semilogy(PdB,Prob_R1(:,(w1==0.2)),':b');
% semilogy(PdB,Prob_R1(:,(w1==0.3)),'-.b');
% semilogy(PdB,Prob_R1(:,(w1==0.4)),'-r');
% semilogy(PdB,Prob_R1(:,(w1==w1(end))),'--r');
% %
% % Prob_R1_Theo = ER < 1;
% % semilogy(PdB,Prob_R1_Theo(:,(w1==0)),'-ob');
% % semilogy(PdB,Prob_R1_Theo(:,(w1==0.1)),'--ob');
% % semilogy(PdB,Prob_R1_Theo(:,(w1==0.2)),':ob');
% % semilogy(PdB,Prob_R1_Theo(:,(w1==0.3)),':ob');
% % semilogy(PdB,Prob_R1_Theo(:,(w1==0.4)),'-or');
% % semilogy(PdB,Prob_R1_Theo(:,(w1==0.5)),'--or');
% xlabel('SNR [dB]'); ylabel('Pr \{R_1 < R_{1,QoS}\}'); title(['When R_{1,QoS} = ',num2str(R1_QoS),' bps'])
% legend('w1=0.01,    w3=0.99','w1=0.1, w3=0.8','w1=0.2, w3=0.6','w1=0.3, w3=0.4','w1=0.4, w3=0.2','w1=0.49, w3=0.01', 'location', 'best')
% eval(['saveas(gcf,''Outage_versus_SNR_R1_QOS',num2str(R1_QoS),'.fig'');'])
%
% figure
% surf(PdB,w1,R1');
% ylabel('Normalized Bandwidth of dedicated resource');ylim([0 0.5])
% xlabel('SNR [dB]'); xlim([min(PdB) max(PdB)])
% zlabel('Rate of a given UE [bps/Hz]')
% eval(['saveas(gcf,''Surface_Rate_BW_SNR.fig'');'])
%
% figure
% subplot(211)
% [c,i]=max(R1');
% plot(PdB,w1(i),'-'); hold on
% plot(PdB,W - 2*w1(i),'-r'); hold on
% ylabel('Optimal bandwidth, w_x [Hz]');ylim([min(w1) max(w1)+0.1])
% xlabel('SNR [dB]')
% legend('Optimal w_1 = w_2','Optimal w_3 = W - 2w_1', 'location', 'best')
%
% subplot(212)
% [c_ER,i]=max(ER');
% plot(PdB,c_ER,'-o');hold on
% plot(PdB,c);
% ylabel('Rate achieved with Optimal w_m [bps]')
% xlabel('SNR [dB]'); xlim([min(PdB) max(PdB)])
% legend('Theoretical: max(ER)','Simulated', 'location', 'best')
% eval(['saveas(gcf,''Optimal_dedicated_BW_w1.fig'');'])
%
% figure
% plot(w1,R1((PdB == -2),:),'-b'); hold on;
% plot(w1,R1((PdB == 0),:),':b');
% plot(w1,R1((PdB == 2),:),'-.b');
% plot(w1,R1((PdB == 4),:),'-r');
% xlabel('Normalized Bandwidth with equal Dedicated Resources for 2 UEs [dB]'); ylabel('Rate of a given UE [bits/s/Hz]');
% legend('SNR = -2 dB','SNR = 0 dB','SNR = 2 dB','SNR = 4 dB', 'location', 'best')
% eval(['saveas(gcf,''ErgodicRate_versus_BW.fig'');'])