function move_to_base_dir {
  cd $(dirname "$0")
}

function runDifference {
  numdiff target $1 \
    --absolute-tolerance 1.e-4 \
    --relative-tolerance 0. \
    --output log.out \
    --warnings log.warnings

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

function cleanSimulation {
  rm -f log.*
}
