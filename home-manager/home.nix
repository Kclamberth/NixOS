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
    #generic
    ( nerdfonts.override { fonts = [ "JetBrainsMono" ]; } )

    #utils
    neofetch
    htop
    swww
    pavucontrol
    libnotify
    ffmpeg
    grim
    mpv
    unzip

    #misc
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

  dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
  };

  home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
  };

  qt = {
      enable = true;
      platformTheme.name = "gtk"; # gnome
  };

  gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Macchiato-Compact-Mauve-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = ["mauve"];
          size = "compact";
          #tweaks = [ "rimless" "black" ];
          variant = "macchiato";
        };
  };

  iconTheme = {
        package = pkgs.gnome.adwaita-icon-theme;
        name = "Adwaita";
        #name = "Yaru-magenta-dark";
        #package = pkgs.yaru-theme;
  };

  gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
  };

  gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
  };

  #font = {
      #  name = "Sans";
      #  size = 11;
      #};
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
     
	sub-font="JetBrains Mono";
	osd-font="JetBrains Mono";
     };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      exec-once = [
        "swww-daemon"
        "swww img ~/.config/home-manager/Wallpapers/wallpaper.png"
        "waybar"
        "dunst"
      ];
      monitor = ",preferred,auto,1";
      env = [
	  "XCURSOR_SIZE=24"
	  #"GDK_DPI_SCALE=1.5"
      ];
      input = {
        kb_layout = "us";
        # kb_variant =
        # kb_model =
        # kb_options = "grp:win_space_toggle";
        # kb_rules =

        follow_mouse = 1;

        touchpad = { natural_scroll = "yes"; };

        sensitivity = 0;
      };

      general = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        gaps_in = 5;
        gaps_out = [ 5 5 5 5 ];
        border_size = 1;
        "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
        "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";

        layout = "dwindle";

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;
      };

      decoration = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 8;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 28;
        shadow_render_power = 3;
        #"col.shadow" = "rgba(1a1a1aee)";
	"col.shadow" = "rgba(00000045)";
      };

      animations = {
        enabled = "yes";
	first_launch_animation = true;

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

	bezier = [
	"slidein, 0.39, 0.575, 0.565, 1"
    	"myBezier, 0.05, 0.9, 0.1, 1.05"
    	"linear, 0.0, 0.0, 0.0, 0.0"
    	"woosh, 0.445, 0.05, 0, 1"
	];

        animation = [
	  "borderangle, 1, 40, linear, loop"
	  "windowsMove, 1, 5, default"
	  "layers, 1, 2, woosh, slide"
	  "windowsIn, 1, 2, woosh, slide"
	  "windows, 1, 7, default, slide"
	  "windowsOut, 1, 5, woosh, slide"
	  "fadeSwitch, 1, 7, default"
	  "fadeOut, 1, 5, linear"
	  "workspaces, 1, 4, woosh, slide"
        ];
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        pseudotile = "yes";
        # you probably want this
        preserve_split = "yes";
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true;
      };
      gestures = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = "off";
      };

      misc = {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper =
          -1; # Set to 0 to disable the anime mascot wallpapers
      };
      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      #"device:epic-mouse-v1" = { sensitivity = -0.5; };

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # windowrule = [
      #  "float,polkit-kde-authentication-agent-1"
      #  "center,polkit-kde-authentication-agent-1"
      #  "size 500 500,polkit-kde-authentication-agent-1"
      #];

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Q, exec, kitty"
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, V, togglefloating,"
        "$mainMod, S, exec, rofi -show drun --show-icons"
        "$mainMod, P, pseudo,"
	"$mainMod, J, togglesplit,"

        # Move focus with mainMod + arrow keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # ? I don't need it (I think)
        # Example special workspace (scratchpad)
        # "$mainMod, S, togglespecialworkspace, magic"
        # "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, right, workspace, e+1"
        "$mainMod, left, workspace, e-1"

        "$mainMod SHIFT, right, movetoworkspace, +1"
        "$mainMod SHIFT, left, movetoworkspace, -1"

        # Move Windows
        "$mainMod SHIFT, H, movewindow, l"
        "$mainMod SHIFT, L, movewindow, r"
        "$mainMod SHIFT, K, movewindow, u"
        "$mainMod SHIFT, J, movewindow, d"

        # Resize window
        "$mainMod CTRL, l, resizeactive, 50 0"
        "$mainMod CTRL, h, resizeactive, -50 0"
        "$mainMod CTRL, k, resizeactive, 0 -50"
        "$mainMod CTRL, j, resizeactive, 0 50"

      ];

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
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
        font = "Source Sans Pro 10";
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
