cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_BatchReactor.sh

runDifference Output/ReactionRates.out
