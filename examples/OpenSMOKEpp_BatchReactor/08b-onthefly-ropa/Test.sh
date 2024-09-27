cd $(dirname "$0")

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

OpenSMOKEpp_BatchReactor.sh --input input.dic > log.OpenSMOKEpp_BatchReactor.sh

awk 'NR>35' Output/ROPA.out > log.ROPA

runDifference log.ROPA
