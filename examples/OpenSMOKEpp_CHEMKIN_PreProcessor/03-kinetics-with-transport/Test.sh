cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_CHEMKIN_PreProcessor.sh

runDifference kinetics-POLIMI_TOT_NOX_1412/reaction_names.xml
