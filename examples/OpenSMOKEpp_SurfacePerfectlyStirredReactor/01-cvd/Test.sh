cd $(dirname "$0")

. /Users/anobili/.zshrc

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_SurfacePerfectlyStirredReactor.sh

runDifference Output/Output.bulk.out
