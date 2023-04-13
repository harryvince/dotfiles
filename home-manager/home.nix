{ config, pkgs, ... }:

let 
    tpm = pkgs.fetchFromGitHub {
        owner = "tmux-plugins";
        repo = "tpm";
        rev = "master";
        sha256 = "01ribl326n6n0qcq68a8pllbrz6mgw55kxhf9mjdc5vw01zjcvw5";
    };
    tmux_config = builtins.readFile ../.tmux.conf;
in
{
    home = {
        username = "harry";
        homeDirectory = "/home/harry";
        stateVersion = "22.11";
        packages = import ./packages.nix { inherit pkgs; };

        file.".tmux/plugins/tpm" = {
            source = tpm;
        };
    };

    programs.home-manager = {
        enable = true;
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
}
