function [R_UE1_1, R_UE2_2] = CalculateRate_DR36_SR0(H,P, w1, w2, w3, N0)
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
H21_e = H(5,1); H22_e = H(5,2);
H21_f = H(6,1); H22_f = H(6,2);
SNR_UE1_a =  ((norm(H11_a + H12_a)^2))* (Pa/(w1/3)) /N0;
SNR_UE1_b =  ((norm(H11_b + H12_b)^2))* (Pb/(w1/3)) /N0;
SNR_UE1_c =  ((norm(H11_c + H12_c)^2))* (Pc/(w1/3)) /N0;
SNR_UE2_d =  ((norm(H21_d + H22_d)^2))* (Pa/(w2/3)) /N0;
SNR_UE2_e =  ((norm(H21_e + H22_e)^2))* (Pb/(w2/3)) /N0;
SNR_UE2_f =  ((norm(H21_f + H22_f)^2))* (Pc/(w2/3)) /N0;
R_UE1_1 = w1*sum(log2(1+[SNR_UE1_a SNR_UE1_b SNR_UE1_c]));
R_UE2_2 = w2*sum(log2(1+[SNR_UE2_d SNR_UE2_e SNR_UE2_f]));

end