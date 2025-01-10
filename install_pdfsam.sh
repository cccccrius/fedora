#!/bin/bash
#Init

function myDEBInstallFunction() {
gitRepo=$1
filename=$2
DIRTMP=/tmp/temp
mkdir $DIRTMP 2> /dev/null
urlLatest="https://api.github.com/repos/$gitRepo/releases/latest"
rpmFile=$(curl --silent $urlLatest | grep '\.deb"$' | grep -Eo 'https://[^ >]+' | sed 's/.$//')
if [ -n "$4" ]; then
    debFile=$(curl --silent $urlLatest | grep $4 | grep '\.deb"$' | grep -Eo 'https://[^ >]+' | sed 's/.$//')
fi
LOCFILE='/tmp/temp/temp.deb'
WGETOPT='-nv'
sudo \rm $LOCFILE 2> /dev/null
wget -O $LOCFILE $rpmFile $WGETOPT
cd $DIRTMP
sudo ar x $LOCFILE
tar -xf $DIRTMP/data.tar.gz
cd $DIRTMP/opt
sudo cp -r $3 /opt/$3
cd $DIRTMP/usr
sudo cp -r bin /usr/
sudo cp -r share /usr/
tar -xf $DIRTMP/control.tar.gz
sudo ./postinst configure
notify-send "$filename a été installé."
}

myDEBInstallFunction "torakiki/pdfsam" "PDFSam" "pdfsam-basic"
