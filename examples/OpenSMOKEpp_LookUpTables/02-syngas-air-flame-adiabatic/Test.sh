cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_LookUpTables.sh

runDifference	Output/Output_1000_Hz_0_kJkg.out 
