{ pkgs, ... }:

let 
    tpm = pkgs.fetchFromGitHub {
        owner = "tmux-plugins";
        repo = "tpm";
        rev = "master";
        sha256 = "01ribl326n6n0qcq68a8pllbrz6mgw55kxhf9mjdc5vw01zjcvw5";
    };
    config_file = builtins.fromJSON (builtins.readFile ./config.json);
    tmux_config = builtins.readFile ../.tmux.conf;
    homedir = if config_file.system.architecture == "aarch64-darwin" then "Users" else "home";
in
{
    fonts.fontconfig.enable = true;

    home = {
        username = config_file.system.user;
        homeDirectory = "/${homedir}/${config_file.system.user}";
        stateVersion = "22.11";
        packages = import ./packages { inherit pkgs; };

        file = {
            ".tmux/plugins/tpm".source = tpm;
            "bin".source = builtins.toPath ../../bin;
            ".config/nix/nix.conf".source = ./nix.conf;
            ".config/nixpkgs/config.nix".source = ./config.nix;
            ".config/nvim/lua/harry".source = ../nvim/lua/harry;
        };

    };

    programs.home-manager.enable = true;

    programs.git = {
        enable = true;
        userEmail = config_file.git.email;
        userName = config_file.git.name;
    };

    programs.fzf.enable = true;
    programs.zoxide.enable = true;

    programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;

        oh-my-zsh = {
            enable = true;
            plugins = [ "git" "ssh-agent" ];
            theme = "robbyrussell";
        };

        shellAliases = {
            wt = "git worktree";
            lg = "lazygit";
        };

        initExtra = ''
            # Sessionizer binding
            bindkey -s ^f "~/bin/scripts/sessionizer\n"
            # Start Zoxide
            eval "$(zoxide init zsh)"
        '';
    };

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        extraConfig = ''
            lua << EOF
                require("harry")
            EOF
        '';
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
