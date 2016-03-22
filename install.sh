#!/bin/sh

PWD=`pwd`
BIN="/usr/local/bin"

chmod +x msockstat.perl
ln -s $PWD/msockstat.perl $BIN/msockstat && \
echo "Installation done...!"

