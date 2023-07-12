cd $(dirname "$0")

. /Users/anobili/.zshrc

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplicationPlusInfo OpenSMOKEpp_MicrogravityDroplet.sh input.dic thermogravimetry

awk 'NR>34' Output/ROPAL.out > log.ROPA

runDifference log.ROPA
