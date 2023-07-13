cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_SurfacePerfectlyStirredReactor.sh

runDifference Output/Output.bulk.out
