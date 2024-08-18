#!/bin/bash

handle_error() {
    echo -e "\033[31mError: $1\033[0m"
    zenity --error --text="$1"
    exit 1
}

print_info() {
    echo -e "\033[32m$1\033[0m"
}

print_info "Removing Adobe Photoshop files and shortcuts..."

rm -rf ~/.WineApps/Adobe-Photoshop || handle_error "Failed to remove ~/.WineApps/Adobe-Photoshop"
rm -rf ~/.local/share/icons/photoshop.png || handle_error "Failed to remove ~/.local/share/icons/photoshop.png"
rm -rf ~/.local/share/applications/photoshop.desktop || handle_error "Failed to remove ~/.local/share/applications/photoshop.desktop"

print_info "Adobe Photoshop has been successfully uninstalled."
zenity --info --text="Adobe Photoshop has been successfully uninstalled."

exit 0
