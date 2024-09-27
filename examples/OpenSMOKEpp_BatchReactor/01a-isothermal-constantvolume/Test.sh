cd $(dirname "$0")

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_BatchReactor.sh 

filterValues Output/Output.out > Output/Output.filtered

runDifference Output/Output.filtered
