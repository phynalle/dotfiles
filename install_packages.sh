#!/usr/bin/env sh

INSTALLER=

exists () {
    command -v "$1" >/dev/null 2>&1
}

setup_installer() {
    if exists apt ; then
        INSTALLER='apt install'
    elif exists pacman ; then
        INSTALLER='pacman -Syy'
    elif exists yum ; then
        INSTALLER='yum install'
    elif exists dnf ; then
        INSTALLER='dnf install'
    elif exists emerge ; then
        INSTALLER='emerge -av'
    fi
}

install() {
    if [ ! -z "$INSTALLER" ] ; then
        sudo $INSTALLER "$@"
    fi
}


setup_installer
if [ -z "$INSTALLER" ] ; then
    echo "Available package manager not found. Please install fish shell manually."
    exit -1
fi

install gcc fish git ripgrep exa
# fd는 패키지마다 이름이 달라서 따로 설치하자..
echo "Let's install fd-find, manually"
