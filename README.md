# 🖥️ LiquidApplesx NixOS Configuration

[![NixOS](https://img.shields.io/badge/NixOS-24.05-blue.svg?style=flat&logo=nixos&logoColor=white)](https://nixos.org)
[![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-blue?style=flat&logo=wayland&logoColor=white)](https://hyprland.org)
[![License](https://img.shields.io/github/license/LiquidApplesx/nixos?style=flat)](LICENSE)

My personal NixOS configuration built for gaming performance and professional IT work. Based on the excellent [Frost-Phoenix/nixos-config](https://github.com/Frost-Phoenix/nixos-config) with heavy customizations for my workflow.


## 🔧 Hardware Specifications

| Component | Details |
|-----------|---------|
| **CPU** | AMD Ryzen 5 5600X |
| **GPU** | AMD Radeon RX 7700 XT |
| **RAM** | 32GB DDR4 |
| **Storage** | NVMe SSD |
| **Monitors** | 3440x1440@165Hz (Primary) + 2560x1440@165Hz (Secondary) |
| **Host** | Desktop Workstation |

## 🎨 Desktop Environment

<details>
<summary>Click to expand environment details</summary>

| Component | Application |
|-----------|-------------|
| **OS** | NixOS (Flakes) |
| **Window Manager** | Hyprland (Wayland) |
| **Theme** | Gruvbox Dark Hard |
| **Terminal** | Ghostty |
| **Shell** | Zsh + Powerlevel10k |
| **Editor** | VSCodium + Neovim |
| **Launcher** | Rofi |
| **Bar** | Waybar |
| **Notifications** | SwayNotificationCenter |
| **File Manager** | Nemo + Yazi (TUI) |
| **Browser** | Firefox (primary) |

</details>

## ✨ Key Features

### 🎮 Gaming Optimized
- **Steam** with Proton and GameScope support
- **AMD GPU drivers** optimized for RX 7700 XT
- **GameMode** for automatic performance optimization
- **Low-latency audio** configuration for competitive gaming
- **Dual monitor gaming** with proper workspace management

### 💼 Professional IT Tools
- **Remote Access**: Remmina, VNC, RDP clients
- **Network Analysis**: Wireshark, nmap, network monitoring tools
- **Multiple Browsers**: Firefox, Chrome, Edge for compatibility testing
- **Communication**: Slack, Discord, Teams, Zoom
- **Development**: Complete development environment with modern tooling

### ⚡ Performance & Efficiency
- **Minimal overhead** - Hyprland for maximum gaming performance
- **Fast rebuilds** - Modular configuration structure
- **AMD optimizations** - Hardware-specific optimizations
- **Declarative** - Entire system reproducible from configuration

## 🚀 Quick Commands

```bash
# System Management
nix-switch              # Rebuild and switch configuration
nix-update              # Update flake inputs and rebuild  
nix-test                # Test configuration without switching
nix-clean               # Clean old generations

# Development Shortcuts
cdnix                   # Open config directory in VSCodium
g                       # Launch lazygit
y                       # Launch yazi file manager
```

## 📦 Installation

### Prerequisites
- Fresh NixOS installation (use graphical installer)
- Choose "**No desktop**" during installation
- Ensure internet connection is working

### Installation Steps

1. **Boot into your fresh NixOS installation**

2. **Clone this repository**:
   ```bash
   nix-shell -p git
   git clone https://github.com/LiquidApplesx/nixos.git
   cd nixos
   ```

3. **Run the installation script**:
   ```bash
   ./install.sh
   ```

4. **Follow the prompts**:
   - Enter your username when prompted
   - Choose "**desktop**" when asked for host type
   - Choose whether to install Aseprite (skip to save time)

5. **Reboot and enjoy**:
   ```bash
   sudo reboot
   ```

After reboot, you'll be greeted by Hyprland with the Gruvbox theme!

## 🏗️ Project Structure

```
nixos/
├── 📁 flake.nix              # Main flake configuration
├── 📁 flake.lock             # Locked dependency versions
├── 📁 install.sh             # Installation script
├── 📁 hosts/                 # Host-specific configurations
│   ├── 📁 desktop/           # Desktop workstation config
│   │   ├── default.nix       # Host configuration
│   │   ├── hardware-configuration.nix
│   │   └── local-packages.nix
│   └── 📁 laptop/            # Laptop config (if needed)
├── 📁 modules/               # Modular system configuration
│   ├── 📁 core/              # Core system configuration
│   │   ├── bootloader.nix
│   │   ├── hardware.nix
│   │   ├── network.nix
│   │   └── ...
│   └── 📁 home/              # Home Manager configuration
│       ├── 📁 hyprland/      # Window manager settings
│       ├── 📁 programs/      # Application configurations
│       └── 📁 themes/        # Theming and styling
├── 📁 wallpapers/            # Wallpaper collection
└── 📁 LICENSE                # License file
```

## ⌨️ Key Bindings

<details>
<summary>Essential Shortcuts</summary>

### Window Management
| Shortcut | Action |
|----------|--------|
| `Super + Return` | Open terminal |
| `Super + D` | Application launcher |
| `Super + Q` | Close window |
| `Super + F` | Toggle fullscreen |
| `Super + Space` | Toggle floating |

### Workspaces
| Shortcut | Action |
|----------|--------|
| `Super + 1-9` | Switch to workspace |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + Comma/Period` | Switch between monitors |

### Applications
| Shortcut | Action |
|----------|--------|
| `Super + B` | Browser (Firefox) |
| `Super + E` | File manager |
| `Super + V` | Clipboard manager |
| `Super + W` | Wallpaper picker |

</details>

## 🎯 Customization Roadmap

- [x] **Base Configuration** - Hyprland + Gruvbox setup
- [x] **Repository Migration** - Move to personal repository
- [ ] **Gaming Optimizations** - Enhanced Steam and GPU configuration
- [ ] **Dual Monitor Workflow** - Optimized workspace management
- [ ] **IT Tools Integration** - Professional remote access and monitoring tools
- [ ] **Custom Scripts** - Automation and productivity enhancements
- [ ] **Documentation** - Comprehensive setup and usage guides

## 🛠️ Manual Configuration

Some settings still require manual configuration after installation:

### Browsers
- Import bookmarks and configure extensions
- Set up work accounts and profiles
- Configure privacy and security settings

### Git Configuration
Update git settings in `modules/home/git.nix`:
```nix
programs.git = {
  userName = "YourName";
  userEmail = "your@email.com";
  # ...
};
```

### SSH Keys
Generate SSH keys for development:
```bash
ssh-keygen -t ed25519 -C "your@email.com"
# Add public key to GitHub, GitLab, etc.
```

## 🤝 Contributing

This is a personal configuration, but feel free to:
- **Fork** and adapt for your own use
- **Open issues** for questions or suggestions  
- **Submit PRs** for improvements or fixes
- **Share your own configs** inspired by this setup

## 📝 Notes

- Configuration is actively maintained and tested on my daily driver
- All changes are tested before committing to ensure system stability
- Optimized for AMD Ryzen + Radeon hardware combination
- Designed for dual monitor productivity and gaming workflows

## 🙏 Acknowledgments

### Inspiration and Base Configuration
- **[Frost-Phoenix](https://github.com/Frost-Phoenix/nixos-config)** - Excellent foundation and structure
- **[NixOS Community](https://nixos.org/community)** - Amazing support and documentation
- **[Hyprland Community](https://hyprland.org)** - Outstanding Wayland compositor

### Tools and Dependencies
- **[Home Manager](https://github.com/nix-community/home-manager)** - User environment management
- **[Hyprland](https://hyprland.org)** - Dynamic tiling Wayland compositor  
- **[Waybar](https://github.com/Alexays/Waybar)** - Highly customizable status bar
- **[Rofi](https://github.com/davatorium/rofi)** - Application launcher and more

## 📄 License

This configuration is licensed under the [MIT License](LICENSE).

---

<div align="center">

**[⬆ Back to Top](#-liquidapplesx-nixos-configuration)**

Made with ❤️ and lots of ☕ by [LiquidApplesx](https://github.com/LiquidApplesx)

*NixOS: The Purely Functional Linux Distribution*

</div>
