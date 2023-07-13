cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_LaminarFlamelet.sh

runDifference Output/Solution_1_Hz_0_kJkg.out
