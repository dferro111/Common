function DCM = MRP2DCM(MRP)

sig = MRP;
sig_sq = dot(sig, sig);
sig_mat = MatCrossOp(sig);

DCM = eye(3) + (8*sig_mat*sig_mat - 4*(1-sig_sq)*sig_mat) / ((1+sig_sq)^2);