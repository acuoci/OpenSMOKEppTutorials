cd $(dirname "$0")

. /Users/anobili/.zshrc

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_CounterFlowFlame1D.sh

runDifference Output/Sensitivities.mass-flow-rate.xml
