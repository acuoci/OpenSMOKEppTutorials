cd $(dirname "$0")

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

OpenSMOKEpp_BatchReactor.sh --input input.dic > log.OpenSMOKEpp_BatchReactor.sh

runDifference Output/PolimiSoot.out
