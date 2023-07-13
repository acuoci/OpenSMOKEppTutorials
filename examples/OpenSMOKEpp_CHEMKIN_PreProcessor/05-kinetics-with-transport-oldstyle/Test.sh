cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_CHEMKIN_PreProcessor.sh

awk 'NR>5' kinetics-POLIMI_TOT_NOX_1412/idealgas.oldstyle.ascii > log.idealgas

runDifference log.idealgas
