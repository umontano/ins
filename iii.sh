#!/bin/sh
#uncommenting applicable entries in /etc/locale.gen, and running locale-gen
#   For example, uncomment en_US.UTF-8 UTF-8 for American-English:
#/etc/locale.gen
sudo sed 's/# en_US\.UTF-8 UTF-8/en_US\.UTF-8 UTF-8/'  /etc/locale.gen -i
sudo locale-gen
#set the system locale, write the LANG variable to /etc/locale.conf, where en_US.UTF-8
#   belongs to the first column of an uncommented entry in /etc/locale.gen:
#/etc/locale.conf
echo 'LANG=en_US.UTF-8
' | sudo tee /etc/locale.conf
#   Alternatively, run:
sudo localectl set-locale LANG=en_US.UTF-8



sudo apt-get update
sudo apt-get install -y udiskie
sleep 5
udiskie-mount -a
sleep 5
sudo apt-get install -y wget
sudo apt-get install -y git
sudo apt-get install -y curl
sudo apt-get install -y tmux
sudo apt-get install -y fish
sudo apt-get install -y stow
sudo apt-get install -y rclone
sudo apt-get install -y archivemount
sudo apt-get install -y lynx
sudo apt-get install -y vim
sudo apt-get install -y shellcheck
sudo apt-get install -y kodi
sudo apt-get install -y kodi-inputstream-adaptive libnss3
sudo apt-get install -y dillo
sudo apt-get install -y midori
sudo apt-get install -y raspberrypi-ui-mods
#X11
#sudo apt-get install -y xorg
sudo apt-get install -y xserver-xorg
sudo apt-get install -y xinit
sudo apt-get install -y xutils-dev 
sudo apt-get install -y x11-xserver-utils
sudo apt-get install -y libc6 libx11-6 libxinerama1
#COMPILING TOOLS
#sudo apt-get install -y build-essential
##############
sleep 5
udiskie-mount -a
sleep 5
#OMXPLAYER MISSING LIBRARY 
sudo apt-get install -y libbrcmGLESv2
sudo apt-get install -y omxplayer
sleep 5
udiskie-mount -a
sleep 5
#####################################################################################
#SUCKLESS
#sudo apt-get install -y suckless-tools
sudo apt-get install -y fontconfig
sudo apt-get install -y xfonts-terminus
#TO INSTALL SUCKLESS TERMINAL ST, #add Xlib.h
sudo apt-get install -y libx11-dev
sudo apt-get install -y libghc-x11-xft-dev
#Package fontconfig was not found in the pkg-config search path.
#Perhaps you should add the directory containing `fontconfig.pc'
#to the PKG_CONFIG_PATH environment variable
cd ~/
git clone git://git.suckless.org/st
cd ~/st/
make clean; make; sudo make clean install
##############################################
cd ~/
git clone git://git.suckless.org/dmenu
cd ~/dmenu/
make clean; make; sudo make clean install
##############################################
cd ~/
git clone git://git.suckless.org/dwm
cd ~/dwm/
make clean; make; sudo make clean install
##############################################
sleep 5
udiskie-mount -a
sudo apt-get clean
sleep 5
udiskie-mount -a
sleep 5

#ADD TO tty group
sudo adduser "$USER" tty
sudo adduser "$USER" video
sudo adduser "$USER" bluetooth
sleep 5s
udiskie-mount -a
sleep 5s


ln -sv /media/$USER/1/y/y/u/  ~/u
ln -sv /media/$USER/1/y/y/p/  ~/p
sudo ln -sv /media/$USER/1/ /a
sudo ln -sv /media/$USER/K/ /b
sudo ln -sv /media/$USER/K/ /k
sudo mkdir /z
sudo chown "$USER":"$USER" /z
sudo chmod -R 777 /z
ln -sv /media/$USER/1/ /z/x
ln -sv /media/$USER/1/ /z/a
ln -sv /media/$USER/K/ /z/b
sudo chmod -R 777 /z



#####################################################################################
#DOCKER
#sh ~/u/psdockerinstallmanualrasppi.sh
cd $HOME
vvvv=$(which docker) && echo "initiaized [[[ $vvvv ]]]" && \ 
	if test -z $vvvv ; then 
		curl -fsSL https://get.docker.com -o get-docker.sh
		sudo sh get-docker.sh
		sudo usermod -aG docker $USER
	else 
		echo DOCKER ALREADY INSTALLED AT $vvvv
	fi

############################################################
#X11 error only cosole user are allowed
#You can add to
#/etc/X11/Xwrapper.config
#the line
#allowed_users = anybody
sudo cp -v /etc/X11/Xwrapper.config /etc/X11/Xwrapper_config`date +%y%m%d%H%M%s`.txt
echo '
allowed_users = anybody
' | sudo tee -a /etc/X11/Xwrapper.config
#
#STARTX XINIT DWM SETUP
sudo mv -v /etc/X11/xinit/xinitrc /etc/X11/xinit/xinitrcBACKUP`date +%y%m%d%H%M%s`.txt
echo '#!/bin/sh
exec dwm
' | sudo tee /etc/X11/xinit/xinitrc
mv -v ~/.xinitrc ~/xinitrcBACKUP`date +%y%m%d%H%M%s`.txt
echo '#!/bin/sh
exec dwm
' | tee ~/.xinitrc


#####################################################################################
#AUTOSTART MEGADISKIE
cp -v /media/"$USER"/1/y/y/u/installers/auto.sh ~/auto.sh
mkdir -p ~/.config/autostart/
echo '[Desktop Entry]
Type=Application
Name=automegadiskie
Exec=/bin/sh ~/auto.sh
StartupNotify=false
Terminal=false
' | tee ~/.config/autostart/automegadiskie.desktop

echo '
[Unit]
Description=automegadiskie

[Service]
Type=oneshot
ExecStart=/bin/sh ~/auto.sh

[Install]
WantedBy=multi-user.target
' | sudo tee /etc/systemd/system/automegadiskie.service


#####################################################################################
#SYSTEMD SERVICE UNIT EXAMPLE
echo '
[Unit]
Description=Foo

[Service]
ExecStart=/usr/sbin/foo-daemon

[Install]
WantedBy=multi-user.target
'
#sudo systemctl enable jdownloader.service &
#####################################################################################
sh ~/u/installers/qbittorrent-cli_install.sh
sh ~/u/installers/psrpiMEGArepository.sh 
sh ~/u/installers/rpibluealsa2022.sh
sh ~/u/installers/rpipulseaudio.sh
#####################################################################################
sh ~/u/installers/cred.sh
sh ~/u/installers/dotstow.sh
#sh ~/u/installers/bluetoothconnect.sh
sh ~/u/installers/jd.sh
