cd $(dirname "$0")

. /Users/anobili/.zshrc

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_LookUpTables.sh

runDifference Output/Output_1_Hz_0_kJkg.out 
