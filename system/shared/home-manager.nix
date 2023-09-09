{ inputs, system, gitDetails, pkgs, desktop }:

let 
    tpm = pkgs.fetchFromGitHub {
        owner = "tmux-plugins";
        repo = "tpm";
        rev = "master";
        sha256 = "01ribl326n6n0qcq68a8pllbrz6mgw55kxhf9mjdc5vw01zjcvw5";
    };
    tmux_config = builtins.readFile ../../config/.tmux.conf;
    desktop_config = import ./configuration-desktop.nix { inherit pkgs inputs; };
in
{
    imports = if desktop then [ desktop_config ] else [];

    home = {
        stateVersion = "23.05";
        packages = import ./packages.nix { inherit pkgs; };

        file = {
            ".tmux/plugins/tpm".source = tpm;
            "bin".source = builtins.toPath ../../bin;
        };

    };

    programs.git = {
        enable = true;
        userEmail = gitDetails.email;
        userName = gitDetails.username;
    };

    programs.fzf.enable = true;
    programs.zoxide.enable = true;

    programs.kitty = {
        enable = true;
        settings = {
            background_opacity = "0.9";
            font_size = "18";
            enable_audio_bell = false;
        };
        theme = "Catppuccin-Macchiato";
    };

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
        '';
    };

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        plugins = [
            inputs.self.packages.${pkgs.system}.my-nvim
        ];

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
