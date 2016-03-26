#!/bin/sh

PWD=`pwd`
BIN="/usr/local/bin"
PERL=`which perl`
if [ "$PERL" != "" ]; then
  sed -i '' "s#PATH_TO_PERL#${PERL}#" msockstat.perl
else
  echo "Installation failed -- Perl not found..."
  exit 1
fi

chmod +x msockstat.perl
ln -s $PWD/msockstat.perl $BIN/msockstat && \
echo "Installation done...!"

