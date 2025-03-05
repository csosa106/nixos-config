{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true; 

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable i3
  services.xserver.windowManager.i3.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Swap caps and escape
  services.xserver.xkb.options = "caps:escape";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chs = {
    isNormalUser = true;
    description = "Carlos";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
  git
  python312
  virtualenv
  direnv
  htop
  vscode
  neovim
  i3
  ranger
  neofetch
  curl
  wget
  stow
  rxvt-unicode
  xsel
  arandr
  pavucontrol
  spotify
  pulseaudio
  brightnessctl
  xss-lock
  networkmanagerapplet
  nodejs_22
  scrot
  unzip
  google-chrome
  pnpm
  code-cursor
  docker
  zip
  gcc
  prisma
  prisma-engines
  openssl
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  # Set neovim as default editor and alias it with vim
  environment.variables.EDITOR = "nvim";
  environment.variables.VISUAL = "nvim";

  # Helpful Aliases
  programs.bash.shellAliases = {
    vim = "nvim";
    edit = "nvim /home/chs/Config/hosts/laptop/configuration.nix";
    rebuild = "sudo nixos-rebuild switch --flake /home/chs/Config#laptop";
  };

  # Stop X11 from asking password
  programs.ssh.askPassword = "";

  system.stateVersion = "24.11";
}
