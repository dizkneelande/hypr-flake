# 	 	    #
# nell's nix config #
#		    #

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./vm.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "dizkneelande"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable Hyprland.
  programs.hyprland.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nell = {
    isNormalUser = true;
    description = "nell";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "disk" "lp" ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
        # Import Scripts
    (import ../scripts/emopicker9000.nix { inherit pkgs; })
    (import ../scripts/task-waybar.nix { inherit pkgs; })
    (import ../scripts/squirtle.nix { inherit pkgs; })
    # Utils
    vim
    wget
    btop
    htop
    git
    libvirt
    qemu_full
    grim
    slurp
    lm_sensors
    unzip
    unrar
    gnome.file-roller
    gnome-browser-connector
    gnome.gnome-tweaks
    libnotify
    swaynotificationcenter
    tofi
    waybar
    #networkmanager
    networkmanagerapplet
    #bluez
    blueman
    killall
    swww
    imv
    wlr-randr
    kitty
    xfce.thunar
    xfce.tumbler
    v4l-utils
    yt-dlp
    gammastep
    # Misc
    ydotool
    wl-clipboard
    scrcpy
    android-tools
    socat
    cowsay
    lsd
    neofetch
    pkg-config
    cmatrix
    lolcat
    transmission-gtk
    tty-clock
    cool-retro-term
    # Photo & Video
    mpv
    gimp
    obs-studio
    blender
    openshot-qt
    # Online
    firefox
    thunderbird
    discord
    # Dev
    meson
    glibc
    hugo
    gnumake
    ninja
    go
    nodejs_21
    rustup
    vscode
    # Audio and Brightness
    pavucontrol
    pamixer
    audacity
    brightnessctl
    # Fonts and icons
    ubuntu_font_family
    font-awesome
    symbola
    material-icons
    tokyo-night-gtk
    bibata-cursors
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    google-fonts
    corefonts
    vistafonts
  ];
  
  # Nerdfonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Ubuntu" "UbuntuMono" ]; })
  ];

  # Steam Configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  # Nix Package Management
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # List services that you want to enable:
  services.openssh.enable = true;
  services.fstrim.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
  
  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ]; 
}

