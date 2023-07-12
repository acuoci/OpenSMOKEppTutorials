function move_to_base_dir {
  cd $(dirname "$0")
}

function runApplication {
  SOLVERNAME=$1
  DEFAULTINPUT="input.dic"
  SOLVERINPUT=${2-$DEFAULTINPUT}
  echo | $($SOLVERNAME --input $SOLVERINPUT > log.$SOLVERNAME)
}

function runApplicationPlusInfo {
  SOLVERNAME=$1
  DEFAULTINPUT="input.dic"
  SOLVERINPUT=${2-$DEFAULTINPUT}
  INFO=$3
  echo | $($SOLVERNAME --input $SOLVERINPUT --type $3 > log.$SOLVERNAME)
}

function runNumdiff {
  numdiff target $1 \
    --absolute-tolerance 10000. \
    --relative-tolerance 1.e-2 \
    --strict \
    --output log.out \
    --warnings log.warnings \
    $2
}

# -- Main function for testing
# Provide inputs as follows:
# 1) Name of the file to be compared against "target"
# 2) String with additional args for numdiff
function runDifference {
  runNumdiff $1 $2
  LINESOUT=$(wc -l log.out | awk '{ print $1 }')
  LINESREF=2
  if [ $LINESOUT == $LINESREF ]; then
    touch log.diff
  else
    cat log.out log.warnings > log.diff
  fi

  if [ -s log.diff ]; then
    exit 1
  else
    rm log.diff log.out log.warnings
    exit 0
  fi
}

function getColumn {
  awk -F ' ' -v COLUMN="$1" '{ print $COLUMN }' $2 
}

function cleanSimulation {
  rm -f log.*
}

function filterValues {
  # TODO: remove hard-coded tolerance
  FILTERFILE=$1
  awk -F' ' '\
  { \
    for(i=1;i<=NF;i++) \
    { \
      printf "%s ", $i*($i>1.e-12) \
    }; printf "\n"
  }'\
  $FILTERFILE
}

function generateTarget {
  THISPATH=${PWD}
  SOLVERNAME=$(basename $(dirname $THISPATH))

  TESTFILE=Test.sh
  CLEANFILE=Clean.sh
  TARGETFILE=Output.out
  TARGETPATH=Output/${1:-$TARGETFILE}

  echo 'cd $(dirname "$0")' > $TESTFILE
  echo '' >> $TESTFILE
  echo '. $OPENSMOKE_TUTORIALS/etc/testFunctions.sh' >> $TESTFILE
  echo '' >> $TESTFILE
  echo 'cleanSimulation' >> $TESTFILE
  echo '' >> $TESTFILE
  echo $SOLVERNAME.sh '--input input.dic >' log.$SOLVERNAME.sh >> $TESTFILE
  echo '' >> $TESTFILE
  echo 'runDifference' $TARGETPATH >> $TESTFILE

  echo 'rm -rf kinetics BzzFile.txt Output log.*' > $CLEANFILE

  chmod +x $TESTFILE
  chmod +x $CLEANFILE

  ./Test.sh
  cp $TARGETPATH target
  echo 'Target generated on' $TARGETPATH
}

