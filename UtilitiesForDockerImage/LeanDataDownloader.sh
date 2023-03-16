#!/bin/bash

LEAN_FOLDER=Lean
if [ ! -d $LEAN_FOLDER ]
then
    
    echo "clone Lean repo" 
    git clone https://github.com/QuantConnect/Lean.git $LEAN_FOLDER
fi


cd $LEAN_FOLDER
git pull

cp -rfv Data /Shared/Data