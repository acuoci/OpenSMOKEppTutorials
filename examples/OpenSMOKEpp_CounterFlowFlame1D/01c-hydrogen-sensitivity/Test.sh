cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_CounterFlowFlame1D.sh

runDifference Output/Sensitivities.mass-flow-rate.xml
