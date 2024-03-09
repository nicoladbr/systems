{ inputs }: { pkgs, ...}:

{
  home.packages = with pkgs; [
    #cli
    awscli
    azure-cli
    btop
    curl
    eza
    fd
    fzf
    kubectl
    neofetch
    powershell
    ripgrep
    terraform
    tmux
    tree
    unzip
    wget
    zip

    #editors
    jetbrains.idea-ultimate
    jetbrains.rust-rover
    neovim
    vim

    #java
    jdk21
    maven

    #rust
    rustup

    #scala
    sbt
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 14;
        normal = {
          family = "PragmataPro Mono Liga";
        };
      };
      colors = {
        primary = {
          background = "#0C1113";
          foreground = "#ebdbb2";
        };
        normal = {
          black   = "#282828";
          red     = "#cc241d";
          green   = "#98971a";
          yellow  = "#d79921";
          blue    = "#458588";
          magenta = "#b16286";
          cyan    = "#689d6a";
          white   = "#a89984";
        };
        bright = {
          black   = "#928374";
          red     = "#fb4934";
          green   = "#b8bb26";
          yellow  = "#fabd2f";
          blue    = "#83a598";
          magenta = "#d3869b";
          cyan    = "#8ec07c";
          white   = "#ebdbb2";
        };
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history = {
      expireDuplicatesFirst = true;
    };
    shellAliases = {
      d = "docker";
      eza = "eza -al";
      k = "kubectl";
      ll = "eza";
    };
    localVariables = {
      RPROMPT = "";
    };
  };

  home.stateVersion = "23.05";
}
