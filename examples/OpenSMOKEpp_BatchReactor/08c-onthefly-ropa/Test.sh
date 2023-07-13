cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_BatchReactor.sh

awk 'NR>34' Output/ROPA.out > log.ROPA

runDifference log.ROPA
