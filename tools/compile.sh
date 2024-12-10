#!/bin/bash

function installRepoAsLib() {
    mkdir -p "$HOME/Arduino/libraries"
    ln -s "$PWD" "$HOME/Arduino/libraries/."
}

function installCore() { # $1 name, $2 url
    if [ "$2" ]; then
        arduino-cli core update-index --additional-urls $2
        arduino-cli core install $1 --additional-urls $2
    else
        arduino-cli core update-index
        arduino-cli core install $1
    fi
}

function buildSketch() {
    arduino-cli compile --fqbn $1 $2 --warnings more
}

installRepoAsLib
installCore arduino:avr
buildSketch arduino:avr:uno examples/TH02_demo/
