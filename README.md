# Dotfiles

Personal configuration files and utilities managed with [GNU Stow](https://www.gnu.org/software/stow/).

This repository contains a collection of configuration packages, desktop scripts, and system maintenance utilities for a Linux (Hyprland) environment.

The repository is organized into three main areas:

- **`pkg/`** — Modular configuration packages managed through GNU Stow.
- **`Scripts/`** — Everyday scripts for desktop workflows and system interaction.
- **`Useful/`** — Standalone utilities for occasional system administration and configuration tasks.

# Configuration Packages

Each directory under `pkg/` represents an independent GNU Stow package. Packages can be deployed individually, allowing configurations to be selected according to the machine and environment.

### Available Packages

| Package | Application |
|:---|:---|
| `bash` | Bash shell |
| `bat` | Cat alternative with syntax highlighting |
| `btop` | System resource monitor |
| `cava` | Console-based audio visualizer |
| `fastfetch` | System information tool |
| `fish` | Fish shell |
| `git` | Git version control |
| `hyprland` | Wayland compositor |
| `kitty` | GPU-accelerated terminal emulator |
| `starship` | Cross-shell prompt |
| `uwsm` | Universal Wayland Session Manager |
| `yazi` | Terminal file manager |

## Installation

### Prerequisites

- Git
- GNU Stow

On Arch Linux:

```bash
sudo pacman -S git stow
```

### Clone the Repository

```bash
git clone https://github.com/ColorfulBisuketto/Dotfiles.git ~/Dotfiles
cd ~/Dotfiles
rm -rf ./.git
```

### Deploy Configurations

Deploy individual packages using:

```bash
stow -d pkg -t "$HOME" <package>
```

For example:

```bash
stow -d pkg -t "$HOME" bash fish git starship
```

Alternatively, deploy all available packages using the provided wrapper:

```bash
./stow-all.sh
```

### Preview Changes

Before deploying configurations, simulate the operation:

```bash
stow -n -v -d pkg -t "$HOME" <package>
```

## Managing Packages

All commands assume the working directory is the repository root.

| Operation | Command |
|:---|:---|
| Deploy | `stow -d pkg -t "$HOME" <package>` |
| Remove | `stow -D -d pkg -t "$HOME" <package>` |
| Restow | `stow -R -d pkg -t "$HOME" <package>` |
| Simulate | `stow -n -v -d pkg -t "$HOME" <package>` |

### Updating Configurations

Changes to files inside an already-deployed package are reflected immediately through symbolic links.

When adding or removing files, restow the package:

```bash
stow -R -d pkg -t "$HOME" <package>
```

### Handling Conflicts

GNU Stow refuses to create symbolic links when conflicting files already exist in the target directory.

If a conflict occurs:

1. Identify the conflicting file or directory.
2. Back up or manually resolve the conflict.
3. Simulate the deployment to verify the changes.
4. Deploy the package again.

Avoid using `--adopt` unless you explicitly intend to move existing target files into the repository.

# Scripts

The `Scripts/` directory contains small utilities intended for regular use. These scripts are particularly useful when integrated into desktop keybindings or launched through a command runner.

> [!NOTE]
> These scripts may not be perfectly portable and will break if you are using a WM or DE other than hyprland.
> I strongly recommend you edit these manually yourself to suit your needs.

### Available Scripts

| Script | Description |
|:---|:---|
| `brightness.sh` | Controls internal display brightness and external monitor brightness through DDC/CI. Supports `toggle`, `bright`, and `dark` modes. **Adjust the dark/bright values to suit your needs.** |
| `gamer-run.sh` | Launches applications through GameMode and Gamescope, using a 1920×1080 gamescope session, NIS scaling, and MangoApp. |
| `idle-inhibitor.sh` | Starts, stops, toggles, and checks a systemd idle inhibitor. Useful for temporarily preventing automatic idle actions. |
| `kompress-pdf.sh` | Compresses PDF files using Ghostscript. Accepts an input file and an optional output filename. |
| `take-screenshot.sh` | Takes screenshots of a selected area or the currently focused monitor. Copies the image to the clipboard and provides notification actions for viewing, opening the folder, or deleting the screenshot. |
| `toggle-blue-light-filter.sh` | Toggles the Hyprsunset color temperature between 6000 K and 2500 K. |
| `toggle-touchpad.sh` | Toggles a Hyprland input device (**hardcoded in the script**), with optional device-name selection and desktop notifications. |

### Usage

Scripts can be executed directly from the repository:

```bash
./Scripts/<script>
```

Alternatively, install symbolic links into `~/.local/bin` using the provided helper:

```bash
./link-scripts.sh
```

This makes the scripts accessible by their filenames from anywhere in the terminal.

#### Linking Options

`link-scripts.sh` supports the following options:

| Option | Description |
|:---|:---|
| `-h` | Display help |
| `-n` | Dry run; do not create symbolic links |
| `-d DIR` | Specify a custom installation directory |

Examples:

```bash
# Preview the operation
./link-scripts.sh -n

# Use the default ~/.local/bin directory
./link-scripts.sh

# Use a custom directory
./link-scripts.sh -d /usr/local/bin
```

The destination directory must already exist and be writable.

### Script Dependencies

Some scripts rely on external applications or desktop-specific utilities.

| Script | Dependencies |
|:---|:---|
| `brightness.sh` | `brightnessctl`, `ddcutil` |
| `gamer-run.sh` | `gamemode`, `gamescope`, `mangohud` (MangoApp) |
| `idle-inhibitor.sh` | `systemd` |
| `kompress-pdf.sh` | `ghostscript` |
| `take-screenshot.sh` | `grim`, `slurp`, `hyprctl`, `wl-clipboard`, `libnotify`, `uwsm`, `xdg-utils`, `gio` |
| `toggle-blue-light-filter.sh` | `hyprctl`, `hyprsunset` |
| `toggle-touchpad.sh` | `hyprctl`, `libnotify` |

Some scripts are specifically designed for Hyprland and may require adjustments when used in other desktop environments.

# Useful Utilities

The `Useful/` directory contains standalone scripts for occasional system administration and hardware configuration tasks.

Unlike the scripts in `Scripts/`, these are not intended to be part of the regular desktop workflow.

### Available Utilities

| Script | Description |
|:---|:---|
| `create-gpu-rule.sh` | Interactively creates a persistent udev rule that assigns a readable DRM device symlink to a selected PCI display controller. |
| `limit-battery.sh` | Configures a battery charging threshold and creates a systemd service to restore the threshold across system startup and power-state transitions. |
| `refresh-rules.sh` | Reloads udev rules and triggers device events so that updated rules can take effect. |

### Usage

Execute the desired utility directly:

```bash
./Useful/<script>
```

Some utilities require elevated privileges.

#### GPU Device Rules

`create-gpu-rule.sh` interactively discovers available PCI display controllers and allows you to select one.

It then asks for a readable device name and generates a corresponding udev rule under:

```text
/etc/udev/rules.d/
```

This creates a consistent DRM device symlink, making it easier to reference a particular GPU in applications and configurations.

After creating a rule, refresh the udev rules:

```bash
sudo ./Useful/refresh-rules.sh
```

#### Battery Charging Limit

`limit-battery.sh` accepts a charging threshold between 1 and 100.

For example, to limit charging to 80%:

```bash
./Useful/limit-battery.sh 80
```

The script configures the battery charge threshold and installs/enables a systemd service to reapply it.

This utility requires compatible hardware and kernel support for `charge_control_end_threshold`.

# Adding New Configurations

### Adding a Stow Package

1. Create a new directory under `pkg/`.
2. Reproduce the target directory structure inside the package.
3. Add the configuration files.
4. Deploy the package using GNU Stow.

For example, a configuration targeting `~/.config/example/` would have this structure:

```text
pkg/
└── example/
    └── .config/
        └── example/
            └── config
```

Deploy it with:

```bash
stow -d pkg -t "$HOME" example
```

### Adding a Script

1. Create the script under `Scripts/`.
2. Make it executable:

```bash
chmod +x Scripts/<script>
```

3. Install or refresh the symbolic links:

```bash
./link-scripts.sh
```

### Adding a Utility

Standalone utilities belong under `Useful/`. Keep scripts self-contained and document any required privileges, dependencies, or system-specific assumptions.

---

## Notes

- Configuration packages are managed independently through GNU Stow.
- Scripts and utilities are separate from the Stow package system.
- Desktop scripts may depend on Hyprland, Wayland, or other specific components.
- System utilities may require root privileges and compatible hardware.
- Always review administrative scripts before executing them, particularly those that modify system configuration.

*Personal configurations and utilities maintained for Linux systems. Feel free to browse, adapt, and reuse anything useful.*

*This README is AI slop. I've tried to keep attribution within the individual scripts if I've stolen them.*
