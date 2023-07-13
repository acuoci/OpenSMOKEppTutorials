cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_CHEMKIN_PreProcessor.sh

runDifference kinetics-POLIMI_C1C3HT_1412/TransportProperties_Coefficients.out
