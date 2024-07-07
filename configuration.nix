{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-laptop";
  networking.networkmanager.enable = true;

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  time.timeZone = "America/Chicago";
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

  services.xserver.enable = true;
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.printing.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.libinput.enable = true;

  users.users.alexander = {
    description = "Alex";
    extraGroups = ["networkmanager" "nixos" "wheel"];
    isNormalUser = true;
    shell = pkgs.nushell;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  nixpkgs.config.allowUnfree = true;

  # Programs

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Libraries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glibc
  ];

  # Programs that don't require specific configuration
  environment.systemPackages = with pkgs; [
    alacritty
    alejandra
    audacity
    brave
    clang
    bat
    black
    brave
    cargo
    dust
    eza
    fira-code
    fira-code-nerdfont
    fish
    gimp-with-plugins
    git
    neovim
    obs-studio
    obsidian
    steam
    unzip
    vlc
    nushell
    obs-studio
    obsidian
    ripgrep
    steam
    texlive.combined.scheme-full
    tree-sitter
    unetbootin
    unzip
    vlc
    xclip
    zathura
    zip
    zoxide
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  system.stateVersion = "24.05";
}
