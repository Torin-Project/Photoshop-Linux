#!/bin/bash

GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RED="\e[31m"
NC="\e[0m"

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_command() {
    if ! "$@"; then
        log_error "Error executing command: $@"
        exit 1
    fi
}

log_info "Creating directories and initializing environment..."
check_command mkdir -p "$1/Adobe-Photoshop"

log_info "Downloading winetricks..."
check_command wget -q https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
check_command chmod +x winetricks

log_info "Setting up WINE environment..."
check_command WINEPREFIX="$1/Adobe-Photoshop" wineboot
echo "10" > "$1/progress.mimifile"

log_info "Setting Windows version to 10..."
check_command WINEPREFIX="$1/Adobe-Photoshop" ./winetricks win10

log_info "Downloading redistributables..."
check_command curl -Ls "https://drive.google.com/uc?export=download&id=1qcmyHzWerZ39OhW0y4VQ-hOy7639bJPO" -o allredist.tar.xz
check_command mkdir allredist
echo "20" > "$1/progress.mimifile"

log_info "Extracting redistributables..."
check_command tar -xf allredist.tar.xz
check_command rm -f allredist.tar.xz
echo "25" > "$1/progress.mimifile"

log_info "Extracting Adobe Photoshop..."
if [ ! -f "AdobePhotoshop2021.tar.xz" ]; then
    log_error "AdobePhotoshop2021.tar.xz not found! Please ensure the file is in the same directory as this script."
    exit 1
fi
check_command tar -xf AdobePhotoshop2021.tar.xz
check_command rm -f AdobePhotoshop2021.tar.xz
echo "50" > "$1/progress.mimifile"

log_info "Installing necessary components using winetricks..."
check_command WINEPREFIX="$1/Adobe-Photoshop" ./winetricks fontsmooth=rgb gdiplus msxml3 msxml6 atmlib corefonts dxvk win10 vkd3d
echo "70" > "$1/progress.mimifile"

log_info "Installing Visual C++ Redistributables..."
check_command WINEPREFIX="$1/Adobe-Photoshop" wine allredist/redist/2010/vcredist_x64.exe /q /norestart
check_command WINEPREFIX="$1/Adobe-Photoshop" wine allredist/redist/2010/vcredist_x86.exe /q /norestart
check_command WINEPREFIX="$1/Adobe-Photoshop" wine allredist/redist/2012/vcredist_x86.exe /install /quiet /norestart
check_command WINEPREFIX="$1/Adobe-Photoshop" wine allredist/redist/2012/vcredist_x64.exe /install /quiet /norestart
check_command WINEPREFIX="$1/Adobe-Photoshop" wine allredist/redist/2013/vcredist_x86.exe /install /quiet /norestart
check_command WINEPREFIX="$1/Adobe-Photoshop" wine allredist/redist/2013/vcredist_x64.exe /install /quiet /norestart
check_command WINEPREFIX="$1/Adobe-Photoshop" wine allredist/redist/2019/VC_redist.x64.exe /install /quiet /norestart
check_command WINEPREFIX="$1/Adobe-Photoshop" wine allredist/redist/2019/VC_redist.x86.exe /install /quiet /norestart
echo "90" > "$1/progress.mimifile"

log_info "Setting up Photoshop directory..."
check_command mkdir -p "$1/Adobe-Photoshop/drive_c/Program Files/Adobe"
check_command mv "Adobe Photoshop 2021" "$1/Adobe-Photoshop/drive_c/Program Files/Adobe/Adobe Photoshop 2021"

log_info "Creating launcher script..."
cat << EOF > "$1/Adobe-Photoshop/drive_c/launcher.sh"
#!/usr/bin/env bash
SCR_PATH="pspath"
CACHE_PATH="pscache"
RESOURCES_PATH="\$SCR_PATH/resources"
WINE_PREFIX="\$SCR_PATH/prefix"
FILE_PATH=\$(winepath -w "\$1")
export WINEPREFIX="$1/Adobe-Photoshop"
WINEPREFIX="$1/Adobe-Photoshop" DXVK_LOG_PATH="$1/Adobe-Photoshop" DXVK_STATE_CACHE_PATH="$1/Adobe-Photoshop" wine64 "$1/Adobe-Photoshop/drive_c/Program Files/Adobe/Adobe Photoshop 2021/photoshop.exe" \$FILE_PATH
EOF
check_command chmod +x "$1/Adobe-Photoshop/drive_c/launcher.sh"

log_info "Setting WINE to Windows 10 mode..."
check_command WINEPREFIX="$1/Adobe-Photoshop" winecfg -v win10

log_info "Moving icon and creating desktop entry..."
check_command mv allredist/photoshop.png ~/.local/share/icons/photoshop.png

cat << EOF > ~/.local/share/applications/photoshop.desktop
[Desktop Entry]
Name=Adobe Photoshop CC 2021
Exec=bash -c "$1/Adobe-Photoshop/drive_c/launcher.sh %F"
Type=Application
Comment=The industry-standard photo editing software (Wine)
Categories=Graphics;Photography;
Icon=$HOME/.local/share/icons/photoshop.png
MimeType=image/psd;image/x-psd;
StartupWMClass=photoshop.exe
EOF

log_info "Cleaning up..."
check_command rm -rf allredist winetricks

echo "100" > "$1/progress.mimifile"
check_command rm -f "$1/progress.mimifile"

log_success "Installation completed successfully!"
