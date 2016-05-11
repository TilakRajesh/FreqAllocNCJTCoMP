clear; close all; clc
cd delay_Pout
allPdB = [0]; R1_QoS_list = 0%:0.01:20;
% Pout = [10^-5, 10^-4, 10^-3, 10^-2, 10^-1];
for iPdB=1:numel(allPdB )
    for qos=1: 1
        eval(['load log_R1_R2_PdB_',num2str(allPdB (iPdB)),'QoS',num2str(R1_QoS_list(qos)),'.mat w1 W sample_num PdB eta eta_FF Poutage_UE Poutage_UE_FF delay delay_FF DD2 DD2_FF R1_QoS_delay_range Pout2 Pout2_FF'])
        % %         load log_R1_R2_PdB_10QoS_1_0_0.01_20.mat
        Delay2 = squeeze(DD2);
        Delay2_FF = squeeze(DD2_FF);
        Poutage2 = squeeze(Pout2);
        Poutage2_FF = squeeze(Pout2_FF);
        %         R1_Qos_delay2 = squeeze(R1_Qos_delay(1,:,:,2));
        %         R1_Qos_delay2_FF = squeeze(R1_Qos_delay_FF(1,:,:,2));
        %         subplot(221)
        %         semilogx(Pout,Delay2(1,:),'b*-');  hold on;
        %         semilogx(Pout,Delay2(2,:),'mx--');
        %         semilogx(Pout,Delay2(3,:),'r.--');
        %         semilogx(Pout,Delay2(4,:),'k^-');
        %         xlabel('Slow Fading: Outage Probability, \itP^{\rmoutage}_2'); ylabel('Delay, $\bar{D}_2$','interpreter','latex');
        %         subplot(222)
        %         semilogx(Pout,R1_QoS_delay_range,'b*-');  hold on;
        %         semilogx(Pout,R1_Qos_delay2(2,:),'mx--');
        %         semilogx(Pout,R1_QoS_delay_range,'r.--');
        %         semilogx(Pout,R1_QoS_delay_range,'k^-');
        %         xlabel('Slow Fading: Outage Probability, \itP^{\rmoutage}_2'); ylabel('Best \itR\rm_{QoS} [bps]');
        %         subplot(223)
        %         semilogx(Pout,Delay2_FF(1,:),'b*-');  hold on;
        %         semilogx(Pout,Delay2_FF(2,:),'mx--');
        %         semilogx(Pout,Delay2_FF(3,:),'r.--');
        %         semilogx(Pout,Delay2_FF(4,:),'k^-');
        %         xlabel('Fast Fading: Outage Probability, \itP^{\rmoutage}_2'); ylabel('Delay, $\bar{D}_2$','interpreter','latex');
        %         legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=1/2, SR=0', 'location', 'SouthEast')
        %         subplot(224)
        %         semilogx(Pout,R1_QoS_delay_range,'b*-');  hold on;
        %         semilogx(Pout,R1_QoS_delay_range,'mx--');
        %         semilogx(Pout,R1_QoS_delay_range,'r.--');
        %         semilogx(Pout,R1_QoS_delay_range,'k^-');
        %         xlabel('Fast Fading: Outage Probability, \itP^{\rmoutage}_2'); ylabel('Best \itR\rm_{QoS} [bps]');
        %         eval(['saveas(gcf,''Delay_versus_Pout_SNR_',num2str(allPdB(iPdB)),'_R1_QoS_',num2str(R1_QoS_list(qos)),'.epsc'');'])
        %         eval(['saveas(gcf,''Delay_versus_Pout_SNR_',num2str(allPdB(iPdB)),'_R1_QoS_',num2str(R1_QoS_list(qos)),'.fig'');'])
        %% Delay versus R_QoS
%         figure
%         subplot(311)
%         plot(R1_QoS_delay_range,Delay2(1,:),'b*-');  hold on;
%         plot(R1_QoS_delay_range,Delay2(2,:),'mx--');
%         plot(R1_QoS_delay_range,Delay2(3,:),'r.--');
%         plot(R1_QoS_delay_range,Delay2(4,:),'k^-');
%         xlabel('\itR\rm_{QoS} [bps]'); ylabel('Delay, $\bar{D}_2$','interpreter','latex');
%         legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=1/2, SR=0', 'location', 'SouthEast')
%         subplot(312)
%         semilogy(R1_QoS_delay_range,Poutage2(1,:),'b*-');  hold on;
%         semilogy(R1_QoS_delay_range,Poutage2(2,:),'mx--');
%         semilogy(R1_QoS_delay_range,Poutage2(3,:),'r.--');
%         semilogy(R1_QoS_delay_range,Poutage2(4,:),'k^-');
%         ylabel('Outage Probability, \itP^{\rmoutage}_2'); xlabel('\itR\rm_{QoS} [bps]');
%         subplot(313)
%         semilogy(Delay2(1,:),Poutage2(1,:),'b*-');  hold on;
%         semilogy(Delay2(2,:),Poutage2(2,:),'mx--');
%         semilogy(Delay2(3,:),Poutage2(3,:),'r.--');
%         semilogy(Delay2(4,:),Poutage2(4,:),'k^-');
%         xlabel('Delay, $\bar{D}_2$','interpreter','latex'); ylabel('Outage Probability, \itP^{\rmoutage}_2');
%         suptitle('Slow Fading')
%         eval(['saveas(gcf,''Delay_versus_R_QoS_versus_Pout_SNR_',num2str(allPdB(iPdB)),'_R1_QoS_range_max',num2str(max(R1_QoS_delay_range)),'_SlowFading.epsc'');'])
%         eval(['saveas(gcf,''Delay_versus_R_QoS_versus_Pout_SNR_',num2str(allPdB(iPdB)),'_R1_QoS_range_max',num2str(max(R1_QoS_delay_range)),'_SlowFading.fig'');'])
%         figure
%         subplot(311)
%         plot(R1_QoS_delay_range,Delay2_FF(1,:),'b*-');  hold on;
%         plot(R1_QoS_delay_range,Delay2_FF(2,:),'mx--');
%         plot(R1_QoS_delay_range,Delay2_FF(3,:),'r.--');
%         plot(R1_QoS_delay_range,Delay2_FF(4,:),'k^-');
%         xlabel('\itR\rm_{QoS} [bps]'); ylabel('Delay, $\bar{D}_2$','interpreter','latex');
%         legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=1/2, SR=0', 'location', 'SouthEast')
%         subplot(312)
%         semilogy(R1_QoS_delay_range,Poutage2_FF(1,:),'b*-');  hold on;
%         semilogy(R1_QoS_delay_range,Poutage2_FF(2,:),'mx--');
%         semilogy(R1_QoS_delay_range,Poutage2_FF(3,:),'r.--');
%         semilogy(R1_QoS_delay_range,Poutage2_FF(4,:),'k^-');
%         ylabel('Outage Probability, \itP^{\rmoutage}_2'); xlabel('\itR\rm_{QoS} [bps]');
%         subplot(313)
%         semilogy(Delay2_FF(1,:),Poutage2_FF(1,:),'b*-');  hold on;
%         semilogy(Delay2_FF(2,:),Poutage2_FF(2,:),'mx--');
%         semilogy(Delay2_FF(3,:),Poutage2_FF(3,:),'r.--');
%         semilogy(Delay2_FF(4,:),Poutage2_FF(4,:),'k^-');
%         ylabel('Outage Probability, \itP^{\rmoutage}_2');  xlabel('Delay, $\bar{D}_2$','interpreter','latex');
%         suptitle('Fast Fading')
%         eval(['saveas(gcf,''Delay_versus_R_QoS_versus_Pout_SNR_',num2str(allPdB(iPdB)),'_R1_QoS_range_max',num2str(max(R1_QoS_delay_range)),'_FastFading.epsc'');'])
%         eval(['saveas(gcf,''Delay_versus_R_QoS_versus_Pout_SNR_',num2str(allPdB(iPdB)),'_R1_QoS_range_max',num2str(max(R1_QoS_delay_range)),'_FastFading.fig'');'])
%         
    end
end
%% ICC workshop
load log_R1_R2_PdB_10QoS0.mat DD2
% %         load log_R1_R2_PdB_10QoS_1_0_0.01_20.mat
Delay2_PdB10 = squeeze(DD2);
figure
% subplot(211)
plot(R1_QoS_delay_range(1:4e2:end),Delay2(1,1:4e2:end),'b*-');  hold on;
plot(R1_QoS_delay_range(1:4e2:end),Delay2(4,1:4e2:end),'k^-');
plot(R1_QoS_delay_range(1:4e2:end),Delay2_PdB10(1,1:4e2:end),'b*--'); 
plot(R1_QoS_delay_range(1:4e2:end),Delay2_PdB10(4,1:4e2:end),'k^--');
 xlim([-0.05 8])
xlabel('Initial transmission rate, $R_{m,\mathrm{QoS}}$ [bps]','interpreter','latex'); 
ylabel('Average delay, $\bar{D}_{m,2}$','interpreter','latex');
legend('DR=0, SR=1, SNR=0dB','DR=3/6, SR=0, SNR=0dB','DR=0, SR=1, SNR=10dB','DR=3/6, SR=0, SNR=10dB', 'location', 'West')
% subplot(212)
% semilogy(R1_QoS_delay_range(1:1e2:end),Poutage2(1,1:1e2:end),'b*-');  hold on;
% semilogy(R1_QoS_delay_range(1:1e2:end),Poutage2(2,1:1e2:end),'mx--');
% semilogy(R1_QoS_delay_range(1:1e2:end),Poutage2(3,1:1e2:end),'r.--');
% semilogy(R1_QoS_delay_range(1:1e2:end),Poutage2(4,1:1e2:end),'k^-');
% xlim([0 8])
% ylim([10^-5 10^0])
% xlabel('\itR\rm_{\itm\rm,QoS} [bps]'); ylabel('${P}^{\mbox{outage}}_{m,2}$','interpreter','latex');
% legend('DR=0, SR=1','DR=1/6, SR=4/6','DR=2/6, SR=2/6','DR=1/2, SR=0', 'location', 'SouthEast')
fixfig
eval(['saveas(gcf,''ICC_Delay_versus_R_QoS_versus_Pout_SNR_',num2str(allPdB(iPdB)),'_R1_QoS_range_max',num2str(max(R1_QoS_delay_range)),'_SlowFading.epsc'');'])
eval(['saveas(gcf,''ICC_Delay_versus_R_QoS_versus_Pout_SNR_',num2str(allPdB(iPdB)),'_R1_QoS_range_max',num2str(max(R1_QoS_delay_range)),'_SlowFading.fig'');'])