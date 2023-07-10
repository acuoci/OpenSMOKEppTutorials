cd $(dirname "$0")

. /Users/anobili/.zshrc

. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_CHEMKIN_PreProcessor.sh

awk 'NR>11' kinetics-POLIMI_Soot_PCI2019/kinetics.xml > log.kinetics

runDifference log.kinetics
