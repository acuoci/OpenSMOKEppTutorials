cd $(dirname "$0")

. /Users/anobili/.zshrc

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_PerfectlyStirredReactor.sh

awk 'NR>34' Output/ROPA.out > log.ROPA

runDifference log.ROPA
