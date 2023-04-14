{ config, pkgs, ... }:

let 
    tpm = pkgs.fetchFromGitHub {
        owner = "tmux-plugins";
        repo = "tpm";
        rev = "master";
        sha256 = "01ribl326n6n0qcq68a8pllbrz6mgw55kxhf9mjdc5vw01zjcvw5";
    };
    config_file = builtins.fromJSON (builtins.readFile ./config.json);
    tmux_config = builtins.readFile ../.tmux.conf;
in
{
    fonts.fontconfig.enable = true;

    home = {
        username = config_file.system.user;
        homeDirectory = "/home/${config_file.system.user}";
        stateVersion = "22.11";
        packages = import ./packages.nix { inherit pkgs; };

        file.".tmux/plugins/tpm" = {
            source = tpm;
        };

        file."bin" = {
            source = builtins.toPath ../bin;
        };
    };

    programs.home-manager = {
        enable = true;
    };

    programs.git = {
        enable = true;
        userEmail = config_file.git.email;
        userName = config_file.git.name;
    };

    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;

        oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
            theme = "robbyrussell";
        };

        shellAliases = {
            wt = "git worktree";
            lg = "lazygit";
        };

        initExtra = ''
            # Sessionizer binding
            bindkey -s ^f "~/bin/scripts/sessionizer\n"
            # SSM Binding
            bindkey -s ^s "~/bin/scripts/ssm\n"
            bindkey -s ^S "~/bin/scripts/ssm --list-ids\n"
            # Start Zoxide
            eval "$(zoxide init zsh)"
        '';
    };

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
    };

    programs.tmux = {
        enable = true;
        shell = "${pkgs.zsh}/bin/zsh";
        extraConfig = tmux_config;
    };

    programs.lazygit = {
        enable = true;
    };
}
