cd $(dirname "$0")

. /Users/anobili/.zshrc

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_LaminarFlamelet.sh

runDifference Output/Solution_1_Hz_0_kJkg.out
