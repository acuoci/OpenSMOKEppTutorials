cd $(dirname "$0")

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

OpenSMOKEpp_CHEMKIN_PreProcessor.sh --input input.preprocessing.dic > log.OpenSMOKEpp_CHEMKIN_PreProcessor.sh &&
OpenSMOKEpp_MicrogravityDroplet.sh --input input.droplet.dic > log.OpenSMOKEpp_MicrogravityDroplet.sh

runDifference Output/Interface.out
