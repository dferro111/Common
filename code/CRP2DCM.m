function DCM = CRP2DCM(rho)

DCM = 1 / (1 + dot(rho, rho)) * ((1 - dot(rho,rho)) * eye(3) ...
    + 2*(rho*rho') - 2*MatCrossOp(rho));