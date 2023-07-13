cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_CHEMKIN_PreProcessor.sh

awk 'NR>11' kinetics-CVD/kinetics.surface.xml > log.kinetics

runDifference log.kinetics
