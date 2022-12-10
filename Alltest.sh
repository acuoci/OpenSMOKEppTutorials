BASEDIR=$PWD

RED='\033[0;31m'
GREEN='\033[0;32m'
GRAY='\033[0;37m'
RESET='\033[0m'

NTEST=0
NPASS=0
NFAIL=0
NSKIP=0

function printHeader {
  printf "============================================================================\n"
  printf "$1\n"
  printf "============================================================================\n"
}

function checkInstallation {
  if ! command -v $1 &> /dev/null
    then
      echo "$1 could not be found in your system"
    exit
  fi
}

function runTestTarget {

  NTESTHERE=0
  NPASSHERE=0
  NFAILHERE=0
  NSKIPHERE=0

  TARGETNAME=$1
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

function printSummary {
  NPERF=$(($NTEST-$NSKIP))
  printHeader "Summary"
  if [ $NPERF == $NPASS ]; then
    printf "${GREEN} ($NPASS/$NPERF) test passed${RESET}\n"
  else
    printf "${RED} ($NFAIL/$NPERF) test failed${RESET}\n"
  fi
}

checkInstallation numdiff
checkInstallation OpenSMOKEpp_CHEMKIN_PreProcessor.sh

if [ -z "$@" ]; then
  runTestTarget OpenSMOKEpp_BatchReactor
  runTestTarget OpenSMOKEpp_PlugFlowReactor
  runTestTarget OpenSMOKEpp_MicrogravityDroplet
else
  for var in "$@"; do
    TARGETNAME=${var%.*}
    checkInstallation $var
    runTestTarget $TARGETNAME
  done
fi

printSummary

