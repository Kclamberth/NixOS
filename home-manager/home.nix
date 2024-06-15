{ config, pkgs, inputs, ... }:

{
  imports = [
    ./dotfiles
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "kended";
  home.homeDirectory = "/home/kended";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # unfree pkgs
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    # universal utils
    neofetch
    htop
    swww
    libnotify
    ffmpeg
    grim
    mpv
    unzip

    # misc
    discord
    steam
  ];

  home.file = {
  };

  programs.git = {
    enable = true;
    userEmail = "kclamberth@yahoo.com";
    userName = "Kclamberth";
  };

  programs.kitty = {
    enable = true;

    theme = "Catppuccin-Mocha";
    
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };

    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.9";  
      window_padding_width = 5;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      mouse_hide_wait = 60;
      
      ## Tabs
      tab_title_template = "{index}";
      active_tab_font_style = "normal";
      inactive_tab_font_style = "normal";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      active_tab_foreground = "#1e1e2e";
      active_tab_background = "#cba6f7";
      inactive_tab_foreground = "#bac2de";
      inactive_tab_background = "#313244";
    };

    keybindings = {  
      ## Tabs
      "alt+1" = "goto_tab 1";
      "alt+2" = "goto_tab 2";
      "alt+3" = "goto_tab 3";
      "alt+4" = "goto_tab 4";

      ## Unbind
      "ctrl+shift+left" = "no_op";
      "ctrl+shift+right" = "no_op";

    };
  };

  programs.mpv = {
     enable = true;
     config = {
	panscan="1.0";
	hwdec="vaapi";
	profile="gpu-hq";
	scale="ewa_lanczossharp";
	cscale="ewa_lanczossharp";
	deband="yes";
     
	#sub-font="JetBrainsMono Nerd Font";
	#osd-font="JetBrainsMono Nerd Font";
     };
  };

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    settings = {
      global = {
        rounded = "yes";
        origin = "top-right";
        monitor = "0";
        alignment = "left";
        vertical_alignment = "center";
        width = "400";
        height = "400";
        scale = 0;
        gap_size = 0;
        progress_bar = true;
        transparency = 0;
        text_icon_padding = 0;
        separator_color = "frame";
        sort = "yes";
        idle_threshold = 120;
        line_height = 0;
        markup = "full";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        sticky_history = "yes";
        history_length = 20;
        always_run_script = true;
        corner_radius = 10;
        follow = "mouse";
        font = "JetBrainsMono Nerd Font 10";
        format = "<b>%s</b>\\n%b"; #format = "<span foreground='#f3f4f5'><b>%s %p</b></span>\n%b"
        frame_color = "#232323";
        frame_width = 1;
        offset = "15x15";
        horizontal_padding = 10;
        icon_position = "left";
        indicate_hidden = "yes";
        min_icon_size = 0;
        max_icon_size = 64;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_current";
        mouse_right_click = "close_all";
        padding = 10;
        plain_text = "no";
        separator_height = 2;
        show_indicators = "yes";
        shrink = "no";
        word_wrap = "yes";
        browser = "/usr/bin/env librewolf -new-tab";
      };

      fullscreen_delay_everything = {fullscreen = "delay";};

      urgency_critical = {
        background = "#d64e4e";
        foreground = "#f0e0e0";
      };
      urgency_low = {
        background = "#232323";
        foreground = "#2596be";
      };
      urgency_normal = {
        background = "#1e1e2a";
        foreground = "#2596be";
      };
    };
  };

  home.sessionVariables = {
     #EDITOR = "vim";
     #EDITOR set by nixvim
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
