cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_PremixedLaminarFlame1D.sh

runDifference Output/Solution.final.out
