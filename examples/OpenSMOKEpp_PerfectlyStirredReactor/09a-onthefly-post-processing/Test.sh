cd $(dirname "$0")

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

OpenSMOKEpp_PerfectlyStirredReactor.sh --input input.dic > log.OpenSMOKEpp_PerfectlyStirredReactor.sh

runDifference Output/FormationRates.out
