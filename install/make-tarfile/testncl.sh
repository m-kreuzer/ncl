# sh script to switch between versions of NCL
#
# To use: . /contrib/bin/testncl.sh
# To switch back to original version: . /contrib/bin/origncl.sh

export NCARG_ROOT=/contrib/ncl-4.3.0
export PATH=$NCARG_ROOT/bin:$PATH

version=`ncl -V`
echo "You are now using the test version of NCL: $version"

