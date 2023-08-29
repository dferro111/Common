function R = R_ITRF_TEME(JD, GMST, eop2, inv)

MJD = get_mjday(JD);

PM = PolarMotion(MJD, eop2, ~inv);
T = R3(-GMST * deg2rad(15));

if inv
    R = PM * T';
else
    R = T * PM;
end