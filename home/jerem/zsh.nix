{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = "${config.xdg.configHome}/zsh";

    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };

    oh-my-zsh = {
      enable = true;
      theme = ""; # disabled in favour of starship prompt
      plugins = [
        "git"
        "sudo"           # press ESC twice to prefix last cmd with sudo
        "docker"
        "systemd"
        "extract"        # `x archive.tar.gz` extracts anything
        "z"              # jump to frecent directories
        "copypath"       # copy current path to clipboard
        "copyfile"       # copy file contents to clipboard
        "dirhistory"     # Alt+Left/Right to navigate dir history
        "colorize"       # syntax-highlight cat output
        "command-not-found"
      ];
    };

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh-autosuggestions/zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.zsh-history-substring-search;
        file = "share/zsh-history-substring-search/zsh-history-substring-search.zsh";
      }
      {
        name = "zsh-you-should-use";
        src = pkgs.zsh-you-should-use;
        file = "share/zsh/plugins/you-should-use/you-should-use.plugin.zsh";
      }
      {
        name = "zsh-nix-shell";
        src = pkgs.zsh-nix-shell;
        file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
      }
    ];

    initContent = ''
      # History substring search: bind Up/Down arrows
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      # Better completion
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      # Autosuggestion accept with Right arrow or End
      bindkey '^ ' autosuggest-accept

      # Useful aliases
      alias ls='ls --color=auto'
      alias ll='ls -lah'
      alias la='ls -A'
      alias grep='grep --color=auto'
      alias diff='diff --color=auto'
      alias ip='ip --color=auto'
      alias cat='bat --style=plain --paging=never'
      alias tree='eza --tree'
      alias top='btop'
      alias cp='cp -iv'
      alias mv='mv -iv'
      alias rm='rm -iv'
      alias mkdir='mkdir -pv'
      alias df='df -h'
      alias du='du -sh'
      alias rebuild='sudo nixos-rebuild switch --flake /etc/nixos#t-800'
      # Show system info on terminal start
    fastfetch
  '';
  };

  # Starship: cross-shell prompt (replaces oh-my-zsh themes)
  programs.starship = {
    enable = true;
    settings = {
      format = "$username$hostname$directory$git_branch$git_status$nix_shell$cmd_duration$line_break$character";
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      directory = {
        truncation_length = 4;
        style = "bold blue";
      };
      git_branch = {
        style = "bold purple";
        symbol = " ";
      };
      git_status = {
        style = "bold red";
      };
      nix_shell = {
        symbol = " ";
        style = "bold cyan";
        format = "[$symbol$state]($style) ";
      };
      cmd_duration = {
        min_time = 2000;
        style = "bold yellow";
        format = "[ $duration]($style) ";
      };
    };
  };

  # Extra CLI tools referenced in aliases
  home.packages = with pkgs; [
    bat       # better cat
    eza       # better ls
    btop      # better top
    atop      # advanced process monitor
    htop      # interactive process viewer
    procs     # better ps
    fd        # better find
    ripgrep   # better grep
    fzf       # fuzzy finder
    zoxide    # smarter z
    delta     # better git diff
    fastfetch # system info
    libnotify # provides notify-send
  ];

  # fzf integration
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultOptions = [ "--height 40%" "--border" "--color=dark" ];
  };

  # zoxide (smarter cd, works alongside oh-my-zsh z)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
