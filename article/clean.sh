#!/bin/sh

echo "####################################################################################################"
echo "##### Cleaning master.tex build files"
echo "####################################################################################################"



rm -rf ./build
mkdir -p build/references
mkdir -p build/styles

ln -s "`pwd`/references/references.bib" "`pwd`/build/references/references.bib"
ln -s "`pwd`/styles/IEEEtran.bst" "`pwd`/build/styles/IEEEtran.bst"


echo "\n\n"
echo "++++++++++++++++++++++++++++++++++++++++++++++++"
echo ">>>>> Finished"
echo "++++++++++++++++++++++++++++++++++++++++++++++++"

