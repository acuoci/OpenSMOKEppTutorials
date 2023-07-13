cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_ShockTubeReactor.sh

runDifference Output/Sensitivities.velocity.xml
