function cleanAllCases {
  BASEDIR=${PWD}
  CLEANFILES=$(find examples/* -maxdepth 2 -name 'Clean.sh')
  for file in ${CLEANFILES[@]}; do
    CLEANDIR="$(dirname "${file}")"
    echo "Cleaning $CLEANDIR"
    cd $CLEANDIR && ./Clean.sh && cd $BASEDIR
  done
}
cleanAllCases
