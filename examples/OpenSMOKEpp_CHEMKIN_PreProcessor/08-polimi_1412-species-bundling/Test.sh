cd $(dirname "$0")


. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh

cleanSimulation

runApplication OpenSMOKEpp_CHEMKIN_PreProcessor.sh

runDifference kinetics-POLIMI_PRF_PAH_HT_1412/Kinetics_Summary.out
