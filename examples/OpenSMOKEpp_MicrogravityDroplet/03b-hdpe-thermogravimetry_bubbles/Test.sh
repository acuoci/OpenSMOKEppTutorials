cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplicationPlusInfo OpenSMOKEpp_MicrogravityDroplet.sh input.dic thermogravimetry

runDifference Output/Liquid.out
