#!/bin/bash
clear
echo -e "\e[35m
@@@@@@@@@@@@@@@@@@@@@@                                                                                                                               
@@@@@@@@@@@@@@@@@@@@@@             @@@.    @@@    @@@.     @@@@    @@@@        @@@@@@@@@        @@@@@@@@@@@@@.     .@@@@@@@@@@@@@        @@@@@@@@@  
@@@@@%%@@@%%@@@%%@@@@@             @@@@    @@@    @@@@     @@@@    @@@@       @@@@@@@@@@        @@@@@@@@@@@@@@     @@@@@@@@@@@@@@        @@@@@@@@@  
@@@@@  @@@  @@@  @@@@@             @@@@    @@@    @@@@     @@@@    @@@@       @@@@   @@@@        @@@@@   @@@@@       @@@@@   @@@@       @@@@   @@@@ 
@@@@@            @@@@@             @@@@   @@@@    @@@@     @@@@@@@@@@@@       @@@@   @@@@        @@@@@   @@@@@       @@@@@   @@@@       @@@@   @@@@ 
@@@@@   @    @   @@@@@             @@@@   @@@@    @@@@     @@@@@@@@@@@@       @@@@@@@@@@@        @@@@@   @@@@@       @@@@@   @@@@       @@@@@@@@@@@ 
@@@@@            @@@@@             @@@@###@@@@@##@@@@@     @@@@    @@@@      @@@@@@@@@@@@       #@@@@@###@@@@@     ##@@@@@###@@@@       @@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@             @@@@@@@@@@@@@@@@@@@     @@@@    @@@@      @@@@    @@@@@      @@@@@@@@@@@@@@     @@@@@@@@@@@@@@      @@@@     @@@@
@@@@@@@@@@@@@@@@@@@@@@

Premium makers brand by Velleman
\e[39m
LED Matrix for Basic Learning Kit for RPi python example install script
=======================================================================

"
echo "Enabling SPI..."
sudo raspi-config nonint do_spi 0
echo -e "SPI interface enabled \e[32m\xE2\x9C\x94\e[39m, checking if SPI interface is available..."

if lsmod | grep -q spi; then
    echo -e "Spi kernel driver active, checking interface..."
else
    echo -e "SPI interface not found \xE2\x9D\x8C\n"
    echo -e "Try to \e[4mrestart the RPi\e[24m using the 'sudo reboot' command"
    echo "Exiting setup..."
    exit 1
fi

echo "SPI interfaces:"
ls -A /dev/spi*

if [ $? -eq 0 ]
then
    echo -e "\nSPI interface is available \e[32m\xE2\x9C\x94 \e[39m\n"
else
    echo -e "SPI interface not found \xE2\x9D\x8C\n"
    echo -e "Try to \e[4mrestart the RPi\e[24m using the 'sudo reboot' command"
    echo "Exiting setup..."
    exit 1
fi

echo "Installing dependencies for library..."
sudo usermod -a -G spi,gpio pi
sudo apt install build-essential python3-dev python3-pip libfreetype6-dev libjpeg-dev libopenjp2-7 libtiff5 git

if [ $? -eq 0 ]
then
    echo -e "\nInstalling dependencies was succesfull \e[32m\xE2\x9C\x94 \e[39m\n"
else
    echo -e "Installation failed \xE2\x9D\x8C\n"
    echo -e "Try to \e[4mrestart the RPi\e[24m using the 'sudo reboot' command"
    echo "Exiting setup..."
    exit 1
fi

echo "Upgrading pip3 to latest version..."

sudo -H pip3 install --upgrade --ignore-installed pip setuptools

if [ $? -eq 0 ]
then
    echo -e "\nUpgrade was succesfull \e[32m\xE2\x9C\x94 \e[39m\n"
else
    echo -e "Upgrade failed \xE2\x9D\x8C\n"
    echo -e "Try to \e[4mrestart the RPi\e[24m using the 'sudo reboot' command"
    echo "Exiting setup..."
    exit 1
fi

echo "Installing Luma Led Matrix library..."

sudo -H pip3 install --upgrade luma.led_matrix

if [ $? -eq 0 ]
then
    echo -e "\nInstallation was succesfull \e[32m\xE2\x9C\x94 \e[39m\n"
else
    echo -e "Installation failed \xE2\x9D\x8C\n"
    echo -e "Try to \e[4mrestart the RPi\e[24m using the 'sudo reboot' command"
    echo "Exiting setup..."
    exit 1
fi

echo "Downloading examples..."

git clone https://github.com/rm-hull/luma.led_matrix.git

if [ $? -eq 0 ]
then
    echo -e "\nDownload complete \e[32m\xE2\x9C\x94 \e[39m\n"
else
    echo -e "Download failed \xE2\x9D\x8C\n"
    echo -e "Try to \e[4mrestart the RPi\e[24m using the 'sudo reboot' command"
    echo "Exiting setup..."
    exit 1
fi

read -p "Do you wish to run the test program now? [y/n] " -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    python3 luma.led_matrix/examples/matrix_demo.py
fi
