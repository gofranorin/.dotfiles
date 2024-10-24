# Disk configuration

Use cgdisk to create a 512M EFI partition and leave the rest for root


# BTRFS Setup


mkfs.btrfs /dev/nvme0n1p3
mount /dev/nvme0n1p3 /mnt

btrfs su cr /mnt/@
btrfs su cr /mnt/@home
btrfs su cr /mnt/@snapshots
btrfs su cr /mnt/@var_log

umount /mnt
mount -o noatime,compress=zstd:1,space_cache=v2,subvol=@ /dev/nvme0n1p2 /mnt    

mkdir -p /mnt{boot,home,.snapshots,var_log}

mount -o noatime,compress=zstd:1,space_cache=v2,subvol=@home /dev/nvme0n1p2 /mnt/home   
mount -o noatime,compress=zstd:1,space_cache=v2,subvol=@snapshots /dev/nvme0n1p2 /mnt/.snapshots   
mount -o noatime,compress=zstd:1,space_cache=v2,subvol=@var_log /dev/nvme0n1p2 /mnt/var_log   


#pacstrap packages

base base-devel linux linux-firmware linux-headers vim neovim networkmanager git openssh btrfs-progs

## post-installation things to do whilst on iso

genfstab /mnt >> /mnt/etc/fstab

## chroot

ln -sf /usr/share/zoneinfo/Asia/Dhaka /etc/localtime
hwclock --systohc
vim /etc/locale

install efibootmgr grub reflector snapper bluez bluez-utils xdg-utils xdg-user-dirs pipewire mtools dosfstools zsh

uncomment following locales

bn_BD.UTF-8
en_US.UTF-8


add following in MODULES mkinitcpio.conf

btrfs nvidia nvidia_modeset nvidia_uvm nvidia_drm

in grub config, add 'nvidia-drm.modeset=1' in GRUB_CMDLINE_LINUX_DEFAULT and enable osprober

useradd -m -g users -G wheel (username)
passwd

## Personal Instructions on what to do 

* `xdg-user-dirs-update`


# Themeing 

Stow wallpapers, icons and custom themes.

install lxappearance to save a headache and customize themes there



# Symlinks

ln -s /mnt/disk1/Media/Videos ~/
ln -s /mnt/disk1/Media/Pictures ~/
ln -s /mnt/disk1/Media/Music ~/
ln -s /mnt/disk1/Documents ~/

# Enabling services

fstrim.service
fstrim.timer
systemctl enable systemd-zram-setup@.service
NetworkManager.service
bluetooth.service

# Post Installation

Set up snapper

sudo umount /.snapshots
sudo rm -rf /.snapshots
sudo snapper -c root create-config /
sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots 
sudo mount -a 
sudo chmod 750 /.snapshots
sudo chmod a+rx /.snapshots
sudo chown :username /.snapshots


edit '/etc/snapper/configs/root'
allow users by adding username
set all timeline cleanup values to 0, except min age and set hourly to 5 and daily to 7

sudo systemctl enable --now snapper-timeline.timer


Set up nohang
Check out arch wiki to set up zram configuration

install

noto-fonts nvidia nvidia-utils lib32-nvidia-utils egl-wayland hyprland sddm foot

git clone and makepkg paru
oget snap-pac-grub from aur

# Hooks for backuping kernel updates

sudo mkdir /etc/pacman.d/hooks
sudo nvim /etc/pacman.d/hooks/50-bootbackup.hook

Create hook for Nvidia driver updates

[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove 
Type = Path
Target boot/*

[Action}
Depends = rsync
Description = Backup up /boot
When = PreTransaction
Exec = /ustr/bin/rsync -a --delete /boot /.bootbackup_


sudo pacman -S rsync
