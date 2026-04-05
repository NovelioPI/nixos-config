{ self, inputs, ... }:

{
  flake.nixosModules.cli = { pkgs, ... }: 
  
  {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];

    environment.systemPackages = with pkgs; [
      ripgrep
      tldr
      eza
      bat
      fastfetch
      btop
      yazi
      just
      lazygit
      delta
      tmux
      cava
      atuin 
      fzf
    ];

    programs.git.enable = true;
    
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      histSize = 10000;
      histFile = "$HOME/.zsh_history";

      shellAliases = {
        ls = "eza --icons --group-directories-first";
        l = "eza -lh --icons --git";
        la = "eza -lah --icons";
        tree = "eza --tree";
        cat = "bat";
        grep = "rg";
        c = "clear";
        ".." = "cd ..";
      };

      interactiveShellInit = ''
        fastfetch
        
        eval "$(atuin init zsh)"
        eval "$(fzf --zsh)"
      '';
    };

    programs.starship = {
      enable = true;
      settings = {
        add_newline = true;
        format = "$directory$git_branch$git_status$nodejs$rust$python$cmd_duration\n$character";

        character = {
          success_symbol = "[❯](bold green)";
          error_symbol = "[❯](bold red)";
        };

        directory = {
          style = "bold blue";
          truncation_length = 3;
        };

        git_branch = {
          symbol = " ";
          style = "bold yellow";
        };

        git_status.style = "bold red";
      };
    };

    environment.variables = {
      COLORTERM = "truecolor";
      BAT_THEME = "ansi"; 
      FZF_DEFAULT_OPTS = "--border=rounded --inline-info";
    };
  };
}