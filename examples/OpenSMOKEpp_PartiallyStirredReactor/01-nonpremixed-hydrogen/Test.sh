cd $(dirname "$0")

. /Users/anobili/.zshrc

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_PartiallyStirredReactor.sh

runDifference Output/averages.out
