cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_ThermodynamicEquilibrium.sh

runDifference Output/FinalSummary.out
