# Nix Shell Configuration  

# Usage:
#   nix-shell              # Enter the development environment
#   nix-shell --run nvim   # Launch Neovim directly

{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # BUILD INPUTS - Packages available in the shell environment
  buildInputs = with pkgs; [
    # Python environment
    python3
    python3Packages.pip
    python3Packages.ipython
    python3Packages.virtualenv
    
    # Python development tools (for LSP and formatters)
    python3Packages.black
    python3Packages.isort
    python3Packages.debugpy
    
    # Neovim
    neovim
    
    # Required tools for Neovim plugins
    git              # Required for lazy.nvim
    curl             # For downloading config
    gcc              # Required for treesitter and telescope-fzf
    gnumake          # Required for telescope-fzf-native
    nodejs           # Required for some LSP servers
    ripgrep          # Required for Telescope live_grep
    fd               # Better file finding for Telescope
    
    # Git tools
    lazygit          # LazyGit TUI (optional but recommended)
    
    # Additional useful tools
    tree             # View directory structure
    wget             # Alternative to curl
  ];

  # SHELL HOOK - Commands run when entering the nix-shell
  shellHook = ''
    echo " Python Development Environment with Neovim"
    
    # Create Python virtual environment (optional)
    if [ ! -d .venv ]; then
      echo "Creating Python virtual environment..."
      python -m venv .venv
    fi
    
    # Optionally activate virtual environment
    # source .venv/bin/activate
    
    # Install pyflyby for better Python imports
    pip install --user --quiet pyflyby 2>/dev/null || true
    
    # ============================================================================
    # NEOVIM CONFIGURATION SETUP
    # ============================================================================
    
    # Set custom Neovim config directory
    export NVIM_CONFIG_DIR="$HOME/.config/nvim-nix-shell"
    mkdir -p "$NVIM_CONFIG_DIR"
    
    # GitHub repository information
    REPO_URL="https://raw.githubusercontent.com/rlogger/nvim-config/refs/heads/main/init.lua"
    CONFIG_FILE="$NVIM_CONFIG_DIR/init.lua"
    
    # Download the config if it doesn't exist or is older than 1 day
    if [ ! -f "$CONFIG_FILE" ] || [ $(find "$CONFIG_FILE" -mtime +1 2>/dev/null | wc -l) -gt 0 ]; then
      echo ""
      echo "Downloading custom Neovim config..."
      if curl -fsSL "$REPO_URL" -o "$CONFIG_FILE"; then
        echo "Config downloaded successfully"
      else
        echo "Failed to download config. Using existing or default config."
      fi
    else
      echo "Using cached Neovim config"
    fi
    
    # ============================================================================
    # ALIASES AND ENVIRONMENT VARIABLES
    # ============================================================================
    
    # Neovim aliases using custom config
    alias nvim='nvim -u "$NVIM_CONFIG_DIR/init.lua"'
    alias vim='nvim -u "$NVIM_CONFIG_DIR/init.lua"'
    alias vi='nvim -u "$NVIM_CONFIG_DIR/init.lua"'
    
    # Python aliases
    alias python='python3'
    alias pip='pip3'
    
    # Git aliases (optional convenience)
    alias lg='lazygit'
    alias gs='git status'
    alias gd='git diff'
    alias ga='git add'
    alias gc='git commit'
    alias gp='git push'
    alias gl='git pull'
    
    # ============================================================================
    # ENVIRONMENT VARIABLES FOR NEOVIM
    # ============================================================================
    
    # XDG Base Directory Specification
    export XDG_CONFIG_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}"
    export XDG_DATA_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}"
    export XDG_CACHE_HOME="''${XDG_CACHE_HOME:-$HOME/.cache}"
    
    # Ensure Neovim data directories exist
    mkdir -p "$XDG_DATA_HOME/nvim/site/pack"
    mkdir -p "$XDG_CACHE_HOME/nvim"
    
    # Python environment for LSP
    export PYTHON_PATH="$(which python3)"
    
    # ============================================================================
    # WELCOME MESSAGE
    # ============================================================================
    
    echo ""
    echo " Neovim config: $NVIM_CONFIG_DIR/init.lua"
    echo ""
    echo " Quick Start:"
    echo "   nvim              - Launch Neovim"
    echo "   nvim <file>       - Open a file"
    echo "   lg                - Launch LazyGit"
    echo ""
    echo " First Time Setup:"
    echo "   1. Launch nvim"
    echo "   2. Wait for plugins to install automatically"
    echo "   3. Run :checkhealth to verify setup"
    echo "   4. Run :Mason to check LSP servers"
    echo ""
    echo " Key Bindings:"
    echo "   <Space>          - Leader key"
    echo "   <leader>e        - File explorer"
    echo "   <leader>sf       - Find files"
    echo "   <leader>sg       - Search in files"
    echo "   <leader>gg       - LazyGit"
    echo "   gd               - Go to definition"
    echo "   K                - Show documentation"
    echo "   :Lazy            - Plugin manager"
    echo "   :Mason           - LSP server manager"
    echo ""
    echo "For full keybindings, see: README.md"
    echo "=================================================="
    echo ""
  '';

  # ============================================================================
  # ADDITIONAL SHELL CONFIGURATION
  # ============================================================================
  
  # Set shell prompt to indicate nix-shell environment
  PROMPT_COLOR = "1;32m";  # Green
  
  shellHook = shellHook + ''
    # Custom PS1 prompt
    export PS1="\[\e[$PROMPT_COLOR\][nix-python-dev]\[\e[0m\] \w $ "
  '';
}
