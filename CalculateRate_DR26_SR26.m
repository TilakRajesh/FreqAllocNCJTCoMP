function [R_UE1_1, R_UE2_2, R_UE1_3, R_UE2_3] = CalculateRate_DR26_SR26(H,P, w1, w2, w3, N0)
Pa = P/6;
Pb = P/6;
Pc = P/6;
Pd = P/6;
Pe = P/6;
Pf = P/6;
%%

H11_a = H(1,1); H12_a = H(1,2);
H11_b = H(2,1); H12_b = H(2,2);
H11_c = H(3,1); H12_c = H(3,2);
H21_d = H(4,1); H22_d = H(4,2);
H11_e = H(5,1); H12_e = H(5,2);
H21_e = H(6,1); H22_e = H(6,2);
H11_f = H(7,1); H12_f = H(7,2);
H21_f = H(8,1); H22_f = H(8,2);
SNR_UE1_a =  ((norm(H11_a + H12_a)^2))* (Pa/(w1/2)) /N0;
SNR_UE1_b =  ((norm(H11_b + H12_b)^2))* (Pb/(w1/2)) /N0;
SNR_UE2_c =  ((norm(H11_c + H12_c)^2))* (Pc/(w2/2)) /N0;
SNR_UE2_d =  ((norm(H21_d + H22_d)^2))* (Pd/(w2/2)) /N0;
SINR_UE1_e = ((norm(H11_e + H12_e)^2))*((Pe/2)/(w3/2)) / (N0 + (((norm(H11_e + H12_e)^2))*((Pe/2)/(w3/2))));
SINR_UE2_e = ((norm(H21_e + H22_e)^2))*((Pe/2)/(w3/2)) / (N0 + (((norm(H21_e + H22_e)^2))*((Pe/2)/(w3/2))));
SINR_UE1_f = ((norm(H11_f + H12_f)^2))*((Pf/2)/(w3/2)) / (N0 + (((norm(H11_f + H12_f)^2))*((Pf/2)/(w3/2))));
SINR_UE2_f = ((norm(H21_f + H22_f)^2))*((Pf/2)/(w3/2)) / (N0 + (((norm(H21_f + H22_f)^2))*((Pf/2)/(w3/2))));
R_UE1_1 = w1*sum(log2(1+[SNR_UE1_a SNR_UE1_b ]));
R_UE2_2 = w2*sum(log2(1+[SNR_UE2_c SNR_UE2_d ]));
R_UE1_3 = w3*sum(log2(1+ [ SINR_UE1_e SINR_UE1_f]));
R_UE2_3 = w3*sum(log2(1+ [ SINR_UE2_e SINR_UE2_f]));

end