#!/bin/bash
echo "EXECUTING MASTERBLAN"

if (( $EUID != 0)); then
	echo "please run as root!"
	exit
fi

sed -i "s/#ParallelDownloads.*/ParallelDownloads = 10/" /etc/pacman.conf

echo "## Installing Nvidia Drivers ##"
pacman -S --needed --noconfirm linux-headers nvidia-dkms nvidia-utils egl-wayland
line=$(grep -oP 'GRUB_CMDLINE_LINUX_DEFAULT.*' /etc/default/grub)
if [[$line =~"nvidia_drm"]]; then
	new_line="${line::-1} nvidia_drm.modeset=1\""
	new_line="${new_line//\"/\\\"}"
	sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT.*/$new_line/" /etc/default/grub
fi
grub-mkconfig -o /boot/grub/grub.cfg
sed -i "s/MODULES=.*/MODULES=\(nvidia nvidia_modeset nvidia_uvm nvidia_drm\)/" /etc/mkinitcpio.conf
mkinitcpio -P
touch /etc/environment
echo "LIBVA_DRIVER_NAME=nvidia" >> /etc/environment
echo "XDG_SESSION_TYPE=wayland" >> /etc/environment
echo "__GLX_VENDOR_LIBRARY_NAME=nvidia" >> /etc/environment

echo "## Installing Essentials ##"
pacman -S --needed --noconfirm git wget man-db unzip 

echo "## Installing Desktop Environment ##"
pacman -S --needed --noconfirm sway swaylock swayidle swaybg swaync waybar

echo "## Audio Stuff ##"
pacman -S --needed --noconfirm pipewire wireplumber pipewire-audio pipewire-alsa pipewire-pulse pavucontrol

echo "## Installing useful Programs"
pacman -S --needed --noconfirm firefox foot gimp vlc nautilus evince loupe libreoffice-fresh

echo "## Programming Utils and Languages"
pacman -S --needed --noconfirm stow python clang cmake make neovim neofetch htop

echo "## AUR ##"
sudo -u julian git clone https://aur.archlinux.org/yay.git
cd yay
sudo -u julian makepkg -r -si

echo "MASTERBLAN SUCESSFULLY EXECUTED"
echo "Rebooting ..."
sleep 30 && reboot
