# NixOS Configuration

Personal NixOS configuration managed as a Nix flake for a single laptop, with a Danish locale setup and a Wayland-first desktop.

## Structure

```
nixos/
├── flake.nix                  # Main flake entry point
├── flake.lock                 # Pinned dependency versions
├── rebuild.sh                 # Build & deploy automation script
├── hosts/
│   └── laptop/
│       ├── hardware-configuration.nix
│       └── user.nix           # Which modules to enable
└── modules/
    ├── default.nix            # Module aggregator
    ├── system/                # Core OS settings
    ├── niri/                  # Niri Wayland compositor
    ├── gnome/                 # GNOME desktop (alternative)
    ├── git/                   # Git + GitHub CLI
    ├── vscode/                # VS Code
    ├── gcc/                   # C/C++ toolchain
    ├── python/                # Python environment
    ├── discord/               # Discord via Flatpak
    ├── flatpak/               # Flatpak support
    └── cloudflared/           # Cloudflare tunnel + FreeRDP
```

## Flake Inputs

| Input | Source |
|---|---|
| `nixpkgs` | `nixos-unstable` |
| `home-manager` | `nix-community/home-manager` |
| `nix-flatpak` | `gmodena/nix-flatpak` |

## System Configuration

- **Locale**: `en_GB` with Danish regional settings, `Europe/Copenhagen` timezone, `dk-latin1` keyboard
- **Hardware**: AMD laptop, `systemd-boot`, NVMe/USB/SD storage, ext4 root
- **Audio**: PipeWire with ALSA and PulseAudio compatibility
- **Graphics**: Hardware acceleration with 32-bit support
- **Fonts**: Fira Code, JetBrains Mono, Ubuntu Mono (all Nerd Font variants)
- **GC**: Weekly automatic Nix store cleanup, retains generations newer than 30 days

## Desktop Environment

### Primary: Niri (Wayland scrollable-tiling compositor)

- Configured via split KDL files in `modules/niri/conf/`
- Waybar status bar with workspaces, media controls, CPU/RAM, battery, clock
- Alacritty terminal (JetBrains Mono, 70% opacity)
- Fuzzel launcher, mako notifications, swaylock screen lock
- grim + slurp for screenshots, wl-clipboard for Wayland clipboard

### Alternative: GNOME

- GDM display manager, dark theme by default
- Extensions: Blur My Shell, AppIndicator, Clipboard Indicator
- Custom workspace keybindings (`Super+1–5`), default bloatware removed

## Development Tooling

| Module | Contents |
|---|---|
| `gcc` | GCC 15, CMake, Ninja, GDB, CLion |
| `python` | Python 3 with native library path |
| `git` | diff-so-fancy, gh CLI, rebase defaults, custom colors |
| `vscode` | VS Code (unfree) |

## Deploying

```bash
./rebuild.sh           # Rebuild and switch
./rebuild.sh -u        # Update flake inputs before rebuilding
./rebuild.sh -b        # Build for next boot instead of switching
./rebuild.sh -v        # Verbose build output
./rebuild.sh --no-push # Skip git push after commit
```

The script handles `git stash → pull → rebase` automatically, then commits the result with the generation number (e.g. `NixOS Generation: laptop 41`).

## Module Pattern

Every module follows the same opt-in pattern:

```nix
options.modules.<name>.enable = mkEnableOption "<name>";
config = mkIf cfg.enable { … };
```

Modules configure both system-level (`environment.systemPackages`, etc.) and user-level (`home-manager.users.adam`) settings in a single file. Enable modules in `hosts/laptop/user.nix`.
