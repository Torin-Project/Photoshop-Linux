# Torin Project: Adobe Photoshop on Linux

Welcome to the Torin Project, a solution for installing Adobe Photoshop on Arch-based Linux systems. This project aims to provide a streamlined installation process for Photoshop using Wine.

## Badges

![GitHub issues](https://img.shields.io/github/issues/Torin-Project/Photoshop-Linux)
![GitHub stars](https://img.shields.io/github/stars/Torin-Project/Photoshop-Linux)

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Uninstallation](#uninstallation)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Easy Installation:** Automates the setup of Adobe Photoshop on Arch-based Linux systems.
- **Error Handling:** Robust error handling with user-friendly notifications.
- **Graphical Notifications:** Uses Zenity for clear feedback during installation and uninstallation.

## Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/Torin-Project/Photoshop-Linux.git
   cd Photoshop-Linux
   ```

2. **Run the Installation Script:**
   ```bash
   chmod +x installer.sh
   ./installer.sh
   ```

   Follow the on-screen instructions to complete the installation.

## Usage

To run Adobe Photoshop after installation, use the provided launcher script:

```bash
~/.Adobe-Photoshop/drive_c/launcher.sh
```

You can also access Photoshop from your application menu.

## Uninstallation

To uninstall Adobe Photoshop and related files, use the provided uninstallation script:

```bash
chmod +x uninstaller.sh
./uninstaller.sh
```

This will remove Photoshop and related shortcuts from your system.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a new Pull Request.

For detailed contributing guidelines, please refer to the [CONTRIBUTING.md](CONTRIBUTING.md) file.

## License

This project uses a custom license. Please refer to the [LICENSE.txt](LICENSE.txt) file for detailed licensing terms and conditions. The custom license includes the following:

- Attribution Required
- No Copying or Distribution Without Permission
- No Warranty
- Commercial Use Restrictions
- Compliance with Laws
- Termination of License for Breach

For more information, view the complete license terms in the `LICENSE.txt` file.
