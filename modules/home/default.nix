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

  home.sessionPath = [
    "$HOME/.cargo/bin"
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

      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;

      colors = {
        primary = {
          background = "0x16171E";
          foreground = "0xD1D2D3";
        };

        cursor = {
          text = "0xFEFFFF";
          cursor = "0xc7c7c7";
        };

        normal = {
          black = "0x000000";
          red = "0xE68E8E";
          green = "0x83AC8E";
          yellow ="0xF5B78A";
          blue = "0x9BB8DC";
          magenta = "0xBAACe2";
          cyan = "0x89B8C2";
          white = "0xC7C7C7";
        };

        bright = {
          black = "0x676767";
          red = "0xFF6D67";
          green = "0x5FF967";
          yellow = "0xFEFB67";
          blue = "0x6871FF";
          magenta = "0xFF76FF";
          cyan = "0x95C4CE";
          white = "0xFEFFFF";
        };
      };
    };
  };

  programs.wezterm = {
    enable = true;

    extraConfig = '' 
      return {
        color_scheme = "iceberg-dark",
        font = wezterm.font("PragmataPro Mono Liga"),
        font_size = 14.0,
        hide_tab_bar_if_only_one_tab = true,
      }
    '';
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
      aws = {
        symbol = "aws ";
      };
      azure = {
        symbol = "az ";
      };
      cmd_duration = {
        style = "bold cyan";
      };
      docker_context = {
        symbol = "docker ";
      };
      golang = {
        symbol = "go ";
      };
      java = {
        symbol = "java ";
      };
      lua = {
        symbol = "lua ";
      };
      nodejs = {
        symbol = "node ";
      };
      nix_shell = {
        symbol = "nix ";
      };
      package = {
        disabled = true;
        symbol = "pkg ";
      };
      rust = {
        symbol = "rs ";
      };
      scala = {
        symbol = "scala ";
      };
      terraform = {
        symbol = "terraform ";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    history = {
      expireDuplicatesFirst = true;
    };
    shellAliases = {
      d = "docker";
      eza = "eza -al";
      k = "kubectl";
      ll = "eza";
    };
  };

  home.stateVersion = "23.05";
}
