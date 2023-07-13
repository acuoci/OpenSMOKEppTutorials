cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_MicrogravityDroplet.sh

runDifference Output/Integral.liquid.out
