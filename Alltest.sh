RED='\033[0;31m'
GREEN='\033[0;32m'
GRAY='\033[0;37m'
RESET='\033[0m'

BASEDIR=$PWD

function printHeader {
  printf "============================================================================\n"
  printf "$1\n"
  printf "============================================================================\n"
}

function check_installation {
  if ! command -v $1 &> /dev/null
    then
      echo "$1 could not be found in your system"
    exit
  fi
}

NTEST=0
NPASS=0
NFAIL=0
NSKIP=0

# Init variables
function runTestTarget {

  NTESTHERE=0
  NPASSHERE=0
  NFAILHERE=0
  NSKIPHERE=0

  export TARGETNAME=$1
  printHeader "Running tests for $TARGETNAME"

  TARGETDIR=$BASEDIR/examples/$TARGETNAME
  cd $TARGETDIR

  NTESTHERE=$(find ./* -maxdepth 0 -type d | wc -l)
  NTEST=$(($NTEST+$NTESTHERE))

  for d in *; do
    if [ ! -f $d/Test.sh ]; then
      printf "${GRAY}SKIP${RESET} examples/$TARGETNAME/$d\n"
      NSKIP=$(($NSKIP+1))
    else
      cd $d &&
      ./Test.sh
      if [ $? -eq 0 ]; then
        printf "${GREEN}PASS${RESET} examples/$TARGETNAME/$d\n"
        NPASS=$(($NPASS+1))
      else
        printf "${RED}FAIL${RESET} examples/$TARGETNAME/$d\n"
        NFAIL=$(($NFAIL+1))
      fi
      cd ..
    fi
  done

  cd $BASEDIR
}

check_installation numdiff
check_installation OpenSMOKEpp_CHEMKIN_PreProcessor.sh
runTestTarget OpenSMOKEpp_BatchReactor
runTestTarget OpenSMOKEpp_PlugFlowReactor
runTestTarget OpenSMOKEpp_MicrogravityDroplet

# Print summary
NPERF=$(($NTEST-$NSKIP))
printHeader "Summary"
if [ $NPERF == $NPASS ]; then
  printf "${GREEN} ($NPASS/$NPERF) test passed\n"
else
  printf "${RED} ($NFAIL/$NPERF) test failed\n"
fi
