#!/bin/bash

# Project Motum

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

function setup () {
    echo "Distro Base:"
    echo "1. Debian"
    echo "2. Arch"
    echo -n "Which: "
    read OS

    if [ $OS == 1 ]
    then
        echo "Debian Selected"
        debian_install
    else
        echo "Arch Selected"
        arch_install
    fi
}

function debian_install () {
    echo "Debian Install Started"
    # Chrome
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    apt install ./google-chrome-stable_current_amd64.deb
    # Discord
    wget -0 'discord-0.0.1.deb https://discordapp.com/api/downlaod?platfrom=linux&format=deb'
    apt install ./discord-0.0.1.deb
    # Steam
    add-apt-repository multiverse
    apt install steam
    # Spotify
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
    deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list
    apt-get install spotify-client
    
}

function arch_install () {
    echo "Arch Install Started"
    sed --in-place "s/#EnableAUR/EnableAUR/" "/etc/pamac.conf"
    sed --in-place "s/#CheckAURUpdates/CheckAURUpdates/" "/etc/pamac.conf"

}

setup
