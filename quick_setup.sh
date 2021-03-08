#!/bin/bash

# This script allows you to have a dev environnement quickly

cmd=(
    'python3 -m pip install virtualenv'
    'virtualenv .'
    'source bin/activate'
    'python3 -m pip install Flask'
    'deactivate'
)

for x in "${cmd[@]}"
do
    echo $ $x
    $x
done