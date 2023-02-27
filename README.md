## DWM Bar for OpenRC 

This is a script for a dynamic status bar for DWM (Dynamic Window Manager) that displays various system information such as network status, volume, weather, time, date, RAM usage, CPU usage, battery status, and uptime.
Prerequisites

    DWM (Dynamic Window Manager)
    xsetroot
    OpenRC (for networking)

### Installation 
### DWM 
Debian and Ubuntu

```bash
sudo apt install dwm
```

Fedora

```bash
sudo dnf install dwm
```

Arch Linux

```bash
sudo pacman -S dwm
```

## xsetroot
Debian and Ubuntu

```bash
sudo apt install x11-xserver-utils
```

Fedora

```bash
sudo dnf install xorg-x11-server-utils
```

Arch Linux

```bash
sudo pacman -S xorg-xsetroot
```

Usage

Clone the repository and move to the directory.

```bash
git clone https://github.com/jpx32/dwm_bar.git
cd dwm_bar.git
```

Make the script executable.

```bash
chmod +x dwm-bar.sh
```

Run the script.

```bash
./dwm-bar.sh
```

Credits

This script is based on the dwm-bar script by Luke Smith and modified to work with OpenRC.
License

This project is licensed under the MIT License - see the LICENSE file for details.
