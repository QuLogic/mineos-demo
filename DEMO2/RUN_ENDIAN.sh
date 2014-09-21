#!/bin/sh
#
# Example of the BIG_ENDIAN <===> LOW_ENDIAN conversion.
#
# Usage: RUN_ENDIAN.sh db_name
#
#=========================================================
if test "$#" != 1; then
  echo " Usage: RUN_ENDIAN.sh db_name"
  exit 1
fi
if test ! -f $1.wfdisc; then
  echo " .wfdisc relation $1.wfdisc does not exist"
  exit 1
fi
if test ! -d $1.wfdisc.dat; then
  echo " Directory $1.wfdisc.dat does not exist"
  exit 1
fi

#=========================================================

big=`egrep -e"t4" $1.wfdisc | wc -l`
low=`egrep -e"f4" $1.wfdisc | wc -l`
if test $big != 0 && test $low != 0; then
  echo ".wfdisc includes BIG and LOW orders"
  exit 1
fi

cd $1.wfdisc.dat
if test $big != 0; then
  echo " BIG_ENDIAN ==> LOW_ENDIAN conversion"
  sed -e"s/t4/f4/" ../$1.wfdisc > tmp.$$
  mv tmp.$$ ../$1.wfdisc
  endi 4 [wg].*
else
  echo " LOW_ENDIAN ==> BIG_ENDIAN conversion"
  sed -e"s/f4/t4/" ../$1.wfdisc > tmp.$$
  mv tmp.$$ ../$1.wfdisc
  endi 4 [wg].*
fi
cd ..
