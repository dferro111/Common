function MRP = DCM2MRP(DCM)

[e, t] = DCM2AA(DCM);
MRP = AA2MRP(e, t);