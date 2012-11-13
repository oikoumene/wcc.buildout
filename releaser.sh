#!/bin/sh -e 
TMPDIR=`mktemp -d`
TODAY=`date +"%Y%m%d"`
PYTHON='/usr/bin/python26'
CFG='buildout.cfg'
NAME='wcc.buildout'

set -e

cd $TMPDIR/
git clone $1 prep
cd prep/
if [ "x$2" != "x" ];then
    git checkout $2
fi
$PYTHON bootstrap.py -c $CFG

PRODUCTS=`python -c "from ConfigParser import ConfigParser;cf=ConfigParser();cf.readfp(open('$CFG'));print cf.get('buildout','auto-checkout').replace('\n',' ')"`
mkdir ./egg_repo
./bin/buildout -c $CFG install omelette
for I in $PRODUCTS; do
    ./bin/buildout setup ./dev/$I/setup.py sdist --format=zip
    mv ./dev/$I/dist/*.zip ./egg_repo
done;

cd $TMPDIR/
git clone $1 $NAME
pushd $NAME
if [ "x$2" != "x" ];then
    git checkout $2
fi
popd
mkdir $NAME/egg_repo/
rm -rf `find $NAME -type d -name '.git'`
mv prep/egg_repo/* $NAME/egg_repo/
tar cvjf $NAME-$TODAY.tar.bz2 $NAME/
mv $NAME-$TODAY.tar.bz2 /tmp/
rm -rf $TMPDIR
echo "Released to /tmp/$NAME-$TODAY.tar.bz2"
