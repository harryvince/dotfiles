{ username }:

{ pkgs, ... }:

{
    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
        };
    };

    hardware = {
        opengl.enable = true;

        pulseaudio = {
            enable = true;
            extraConfig = "unload-module module-suspend-on-idle";
            support32Bit = true;
        };
    };

    programs = {
        dconf.enable = true;
        geary.enable = true;
    };

    services = {
        picom.enable = true;

        xserver = {
            enable = true;
            layout = "gb";
            videoDrivers = [
                "vmware"
            ];

            desktopManager = {
                xterm.enable = false;
                wallpaper.mode = "fill";
            };

            displayManager = {
                autoLogin = {
                    enable = true;
                    user = username;
                };
                defaultSession = "none+i3";
                lightdm.enable = true;
            };

        windowManager.i3 = {
            enable = true;
            package = pkgs.i3-gaps;
            extraPackages = with pkgs; [ i3status i3lock i3blocks ];
        };

        };

        logind.extraConfig = ''
            RuntimeDirectorySize=20G
        '';

        openssh = {
            enable = true;
            settings = {
                PasswordAuthentication = false;
                PermitRootLogin = "no";
            };
        };
    };


    sound.enable = true;

    fonts = {
        fontconfig = {
            enable = true;

            defaultFonts = {
                monospace = [ "IntelOne Mono" ];
            };
        };

        packages = with pkgs; [ intel-one-mono ];
    };

    environment = {
        pathsToLink = [ "/libexec" "/share/zsh" ];
        systemPackages = with pkgs; [
            curl
            vim
            wget
            xclip
        ];
    };

    i18n.defaultLocale = "en_GB.UTF-8";

    networking = {
        firewall.enable = false;
        hostName = "${username}-nixos";
    };

    nix = {
        package = pkgs.nixUnstable;

        settings = {
            auto-optimise-store = true;
            builders-use-substitutes = true;
            experimental-features = [ "nix-command" "flakes" ];
            substituters = [
                "https://nix-community.cachix.org"
            ];
            trusted-public-keys = [
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            ];
            trusted-users = [ "@wheel" ];
            warn-dirty = false;
        };
    };

    nixpkgs = {
        config = {
            allowUnfree = true;
            pulseaudio = true;
        };
    };

    programs = {
        zsh.enable = true;
    };

    security.sudo = {
        enable = true;
        wheelNeedsPassword = false;
    };

    system.stateVersion = "23.05";

    time.timeZone = "Europe/London";

    users = {
        mutableUsers = false;
        users."${username}" = {
            extraGroups = [ "docker" "wheel" "audio" ];
            hashedPassword = "";
            home = "/home/${username}";
            isNormalUser = true;
            shell = pkgs.zsh;
        };
    };

    virtualisation = {
        docker.enable = true;

        vmware.guest.enable = true;
    };

}
