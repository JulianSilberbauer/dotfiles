#!/bin/bash
echo "installing essential software"

if (( $EUID != 0)); then
	echo "please run as root!"
	exit
fi

sed -i "s/#ParallelDownloads.*/ParallelDownloads = 10/" /etc/pacman.conf

echo "## Installing Essentials ##"
pacman -S --needed --noconfirm git wget man-db unzip 

echo "## Installing Desktop Environment and Utils ##"
pacman -S --needed --noconfirm waybar hyprland hyprpaper fuzzel

echo "## Audio Stuff ##"
pacman -S --needed --noconfirm pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pavucontrol

echo "## Installing useful Programs"
pacman -S --needed --noconfirm firefox foot gimp vlc nautilus evince loupe libreoffice-fresh

echo "## Programming Utils and Languages"
pacman -S --needed --noconfirm stow python clang cmake make neovim fastfetch htop

echo "## AUR ##"
sudo -u julian git clone https://aur.archlinux.org/yay.git
cd yay
sudo -u julian makepkg -r -si

echo "Finished installing!"
echo "Rebooting in 30s ..."
sleep 30 && reboot
