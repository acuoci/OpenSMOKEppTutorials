cd $(dirname "$0")

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

OpenSMOKEpp_PlugFlowReactor.sh --input input.dic > log.OpenSMOKEpp_PlugFlowReactor.sh

runDifference Output/Output.out
