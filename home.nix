{ config, pkgs, ... }:

{
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
    neovim
    firefox
    ( nerdfonts.override { fonts = [ "JetBrainsMono" ]; } )

    #utils
    neofetch
    htop
    swww
    rofi-wayland
    pavucontrol
    libnotify
    ffmpeg
    grim
    mpv

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
      size = 10;
    };

    settings = {
      confirm_os_window_close = 0;
      background_opacity = "0.8";  
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
	hwdec="auto-safe";
	profile="gpu-hq";
	scale="ewa_lanczossharp";
	cscale="ewa_lanczossharp";
	deband="yes";
     
	sub-font="JetBrains Mono";
	osd-font="JetBrains Mono";
     };
  };

  programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
      style = ''
                        * {
        font-family: "JetBrainsMono Nerd Font";
        font-weight: bold;
        min-height: 0;
        /* set font-size to 100% if font scaling is set to 1.00 using nwg-look */
        font-size: 97%;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
        padding: 1px;
        }

        @define-color base   #1e1e2e;
        @define-color mantle #181825;
        @define-color crust  #11111b;

        @define-color text     #cdd6f4;
        @define-color subtext0 #a6adc8;
        @define-color subtext1 #bac2de;

        @define-color surface0 #313244;
        @define-color surface1 #45475a;
        @define-color surface2 #585b70;

        @define-color overlay0 #6c7086;
        @define-color overlay1 #7f849c;
        @define-color overlay2 #9399b2;

        @define-color blue      #89b4fa;
        @define-color lavender  #b4befe;
        @define-color sapphire  #74c7ec;
        @define-color sky       #89dceb;
        @define-color teal      #94e2d5;
        @define-color green     #a6e3a1;
        @define-color yellow    #f9e2af;
        @define-color peach     #fab387;
        @define-color maroon    #eba0ac;
        @define-color red       #f38ba8;
        @define-color mauve     #cba6f7;
        @define-color pink      #f5c2e7;
        @define-color flamingo  #f2cdcd;
        @define-color rosewater #f5e0dc;

        window#waybar {
          transition-property: background-color;
          transition-duration: 0.5s;
          background: transparent;
          /*border: 2px solid @overlay0;*/
          /*background: @theme_base_color;*/
          border-radius: 10px;
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        #waybar.empty #window {
          background: none;
        }

        /* This section can be use if you want to separate waybar modules */
        .modules-left, .modules-center, .modules-right {
        	background: @theme_base_color;
         	border: 0.5px solid @overlay0;
        	padding-top: 2px;
        	padding-bottom: 2px;
        	padding-right: 4px;
        	padding-left: 4px;
        	border-radius: 10px;

        }

        .modules-left, .modules-right {
          	border: 1px solid @blue;
        	padding-top: 2px;
        	padding-bottom: 2px;
        	padding-right: 4px;
        	padding-left: 4px;
        }

        #backlight,
        #backlight-slider,
        #battery,
        #bluetooth,
        #clock,
        #cpu,
        #disk,
        #idle_inhibitor,
        #keyboard-state,
        #memory,
        #mode,
        #mpris,
        #network,
        #pulseaudio,
        #pulseaudio-slider,
        #taskbar button,
        #taskbar,
        #temperature,
        #tray,
        #window,
        #wireplumber,
        #workspaces,
        #custom-backlight,
        #custom-cycle_wall,
        #custom-keybinds,
        #custom-keyboard,
        #custom-light_dark,
        #custom-lock,
        #custom-menu,
        #custom-power_vertical,
        #custom-power,
        #custom-swaync,
        #custom-updater,
        #custom-weather,
        #custom-weather.clearNight,
        #custom-weather.cloudyFoggyDay,
        #custom-weather.cloudyFoggyNight,
        #custom-weather.default,
        #custom-weather.rainyDay,
        #custom-weather.rainyNight,
        #custom-weather.severe,
        #custom-weather.showyIcyDay,
        #custom-weather.snowyIcyNight,
        #custom-weather.sunnyDay {
        	padding-top: 3px;
        	padding-bottom: 3px;
        	padding-right: 6px;
        	padding-left: 6px;
        }

        #idle_inhibitor {
          color: @blue;
        }

        #bluetooth,
        #backlight {
          color: @blue;
        }

        #battery {
          color: @green;
        }

        @keyframes blink {
          to {
            color: @surface0;
          }
        }

        #battery.critical:not(.charging) {
          background-color: @red;
          color: @theme_text_color;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
          box-shadow: inset 0 -3px transparent;
        }

        #custom-updates {
          color: @blue
        }

        #language {
          color: @blue
        }

        #clock {
          color: @yellow;
        }

        #custom-gpuinfo {
          color: @green;
        }

        #cpu {
          color: @teal;
        }

        #custom-keyboard,
        #memory {
          color: @sky;
        }

        #disk {
          color: @sapphire;
        }

        #temperature {
          color: @teal;
        }

        #temperature.critical {
          background-color: @red;
        }

        #tray > .passive {
          -gtk-icon-effect: dim;
        }
        #tray > .needs-attention {
          -gtk-icon-effect: highlight;
        }

        #keyboard-state {
          color: @flamingo;
        }

        #workspaces button {
            box-shadow: none;
        	text-shadow: none;
            padding: 0px;
            border-radius: 9px;
            padding-left: 4px;
            padding-right: 4px;
            animation: gradient_f 20s ease-in infinite;
            transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
        }

        #workspaces button:hover {
        	border-radius: 10px;
        	color: @overlay0;
        	background-color: @surface0;
         	padding-left: 2px;
            padding-right: 2px;
            animation: gradient_f 20s ease-in infinite;
            transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
        }

        #workspaces button.persistent {
        	color: @surface1;
        	border-radius: 10px;
        }

        #workspaces button.active {
        	color: @peach;
          	border-radius: 10px;
            padding-left: 8px;
            padding-right: 8px;
            animation: gradient_f 20s ease-in infinite;
            transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
        }

        #workspaces button.urgent {
        	color: @red;
         	border-radius: 0px;
        }

        #taskbar button.active {
            padding-left: 8px;
            padding-right: 8px;
            animation: gradient_f 20s ease-in infinite;
            transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
        }

        #taskbar button:hover {
            padding-left: 2px;
            padding-right: 2px;
            animation: gradient_f 20s ease-in infinite;
            transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
        }

        #custom-cava_mviz {
        	color: @pink;
        }

        #cava {
        	color: @pink;
        }

        #mpris {
        	color: @pink;
        }

        #custom-menu {
          color: @rosewater;
        }

        #custom-power {
          color: @red;
        }

        #custom-updater {
          color: @red;
        }

        #custom-light_dark {
          color: @blue;
        }

        #custom-weather {
          color: @lavender;
        }

        #custom-lock {
          color: @maroon;
        }

        #pulseaudio {
          color: @sapphire;
        }

        #pulseaudio.bluetooth {
          color: @pink;
        }
        #pulseaudio.muted {
          color: @red;
        }

        #window {
          color: @mauve;
        }

        #custom-waybar-mpris {
          color:@lavender;
        }

        #network {
          color: @teal;
        }
        #network.disconnected,
        #network.disabled {
          background-color: @surface0;
          color: @text;
        }
        #pulseaudio-slider slider {
        	min-width: 0px;
        	min-height: 0px;
        	opacity: 0;
        	background-image: none;
        	border: none;
        	box-shadow: none;
        }

        #pulseaudio-slider trough {
        	min-width: 80px;
        	min-height: 5px;
        	border-radius: 5px;
        }

        #pulseaudio-slider highlight {
        	min-height: 10px;
        	border-radius: 5px;
        }

        #backlight-slider slider {
        	min-width: 0px;
        	min-height: 0px;
        	opacity: 0;
        	background-image: none;
        	border: none;
        	box-shadow: none;
        }

        #backlight-slider trough {
        	min-width: 80px;
        	min-height: 10px;
        	border-radius: 5px;
        }

        #backlight-slider highlight {
        	min-width: 10px;
        	border-radius: 5px;
        }
      '';
      settings = [
        {
          "layer" = "top";
          "position" = "top";
          #"mode" = "dock";
          "height" = 15;
          "exclusive" = true;
          "passthrough" = false;
          "gtk-layer-shell" = true;
          "ipc" = true;
          "fixed-center" = true;
          "margin-top" = 3;
          "margin-left" = 8;
          "margin-right" = 8;

          # "modules-left" = ["hyprland/workspaces" "mpris" "custom/r_end"];
          "modules-left" = ["hyprland/workspaces" "cava" "custom/r_end"];
          "modules-center" = ["custom/l_end" "idle_inhibitor" "clock" "custom/r_end"];
          "modules-right" = ["custom/l_end" "custom/gpuinfo" "cpu" "memory" "keyboard-state" "network" "bluetooth" "pulseaudio" "temperature" "tray" "battery" "custom/l_end" "custom/power" "custom/padd"];
          #"modules-right" = ["custom/l_end" "temperature" "cpu" "memory" "keyboard-state" "network" "bluetooth" "pulseaudio" "custom/r_end" "hyprland/language" "custom/r_end" "tray" "battery" "custom/l_end" "custom/power" "custom/r_end" "custom/padd" ];
          "custom/colour-temperature" = {
            "format" = "{} ";
            "exec" = "wl-gammarelay-rs watch {t}";
            "on-scroll-up" = "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n +100";
            "on-scroll-down" = "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n -100";
          };
          "cava" = {
            "hide_on_silence" = false;
            "framerate" = 30;
            "bars" = 10;
            "format-icons" = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
            "input_delay" = 1;
            # "noise_reduction" = 0.77;
            "sleep_timer" = 5;
            "bar_delimiter" = 0;
          };
          "custom/gpuinfo" = {
            "exec" = " ~/.config/hypr/scripts/gpuinfo.sh";
            "return-type" = "json";
            "format" = " {}";
            "interval" = 5; # once every 5 seconds
            "tooltip" = true;
            "max-length" = 1000;
          };
          "custom/updates" = {
            "exec" = "~/.config/hypr/scripts/systemupdate.sh";
            "return-type" = "json";
            "format" = "󰮯 {}";
            "on-click" = "~/.config/hypr/scripts/systemupdate.sh up";
            "interval" = 86400; # once every day
            "tooltip" = true;
          };
          "mpris" = {
            "format" = "{player_icon} {title} - {artist}";
            "format-paused" = "{status_icon} <i>{title} - {artist}</i>";
            "player-icons" = {
              "default" = "▶";
              "spotify" = "";
              "mpv" = "󰐹";
              "vlc" = "󰕼";
              "firefox" = "";
              "chromium" = "";
              "kdeconnect" = "";
              "mopidy" = "";
            };
            "status-icons" = {
              "paused" = "⏸";
              "playing" = "";
            };
            "ignored-players" = ["firefox" "chromium"];
            "max-length" = 30;
          };
          "temperature" = {
            # "thermal-zone" = 2;
            "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
            "critical-threshold" = 80;
            # "format-critical" = "{temperatureC}°C {icon}";
            "format" = "{icon} {temperatureC}°C";
            "format-icons" = ["" "" ""];
            "interval" = 2;
          };
          "hyprland/language" = {
            "format" = "{short} {variant}";
            "on-click" = "~/.config/hypr/scripts/keyboardswitch.sh";
          };
          "hyprland/workspaces" = {
            "disable-scroll" = true;
            "all-outputs" = true;
            "active-only" = false;
            "on-click" = "activate";
            "persistent-workspaces" = {
              "*" = [1 2 3 4 5];
            };
          };

          "hyprland/window" = {
            "format" = "  {}";
            "separate-outputs" = true;
            "rewrite" = {
              "harvey@hyprland =(.*)" = "$1 ";
              "(.*) — Mozilla Firefox" = "$1 󰈹";
              "(.*)Mozilla Firefox" = " Firefox 󰈹";
              "(.*) - Visual Studio Code" = "$1 󰨞";
              "(.*)Visual Studio Code" = "Code 󰨞";
              "(.*) — Dolphin" = "$1 󰉋";
              "(.*)Spotify" = "Spotify 󰓇";
              "(.*)Spotify Premium" = "Spotify 󰓇";
              "(.*)Steam" = "Steam 󰓓";
            };
            "max-length" = 1000;
          };

          "idle_inhibitor" = {
            "format" = "{icon}";
            "format-icons" = {
              "activated" = "󰥔";
              "deactivated" = "";
            };
          };

          "clock" = {
	    "format" = "{:%I:%M %p}";
            "format-alt" = "{:%R 󰃭 %m·%d·%y}";
            "tooltip-format" = "<tt>{calendar}</tt>";
            "calendar" = {
              "mode" = "month";
              "mode-mon-col" = 3;
              "on-scroll" = 1;
              "on-click-right" = "mode";
              "format" = {
                "months" = "<span color='#ffead3'><b>{}</b></span>";
                "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
                "today" = "<span color='#ff6699'><b>{}</b></span>";
              };
            };
            "actions" = {
              "on-click-right" = "mode";
              "on-click-forward" = "tz_up";
              "on-click-backward" = "tz_down";
              "on-scroll-up" = "shift_up";
              "on-scroll-down" = "shift_down";
            };
          };

          "cpu" = {
            "interval" = 10;
            "format" = "󰍛 {usage}%";
            "format-alt" = "{icon0}{icon1}{icon2}{icon3}";
            "format-icons" = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          };

          "memory" = {
            "interval" = 10;
            "format" = "󰾆 {percentage}%";
            "format-alt" = "󰾅 {used}GB";
            "max-length" = 10;
            "tooltip" = true;
            "tooltip-format" = " {used =0.1f}GB/{total =0.1f}GB";
          };

          "backlight" = {
            "device" = "intel_backlight";
            "format" = "{icon} {percent}%";
            "format-icons" = ["" "" "" "" "" "" "" "" ""];
            "on-scroll-up" = "brightnessctl set 1%+";
            "on-scroll-down" = "brightnessctl set 1%-";
            "min-length" = 6;
          };

          "network" = {
            # "interface" = "wlp2*"; # (Optional) To force the use of this interface
            "format-wifi" = "󰤨 {signalStrength}%";
            "format-ethernet" = "󱘖 Wired";
            "tooltip-format" = "󱘖 {ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
            "format-linked" = "󱘖 {ifname} (No IP)";
            "format-disconnected" = " Disconnected";
            "format-alt" = "󰤨 {essid}";
            "interval" = 5;
          };

          "bluetooth" = {
            "format" = "";
            "format-disabled" = ""; # an empty format will hide the module
            "format-connected" = " {num_connections}";
            "tooltip-format" = " {device_alias}";
            "tooltip-format-connected" = "{device_enumerate}";
            "tooltip-format-enumerate-connected" = " {device_alias}";
          };

          "pulseaudio" = {
            "format" = "{icon} {volume}";
            "format-muted" = "󰖁";
            "on-click" = "pavucontrol -t 3";
            "tooltip-format" = "{icon} {desc} // {volume}%";
            "scroll-step" = 5;
            "format-icons" = {
              "headphone" = "";
              "hands-free" = "";
              "headset" = "";
              "phone" = "";
              "portable" = "";
              "car" = "";
              "default" = ["" "" ""];
            };
          };

          "pulseaudio#microphone" = {
            "format" = "{format_source}";
            "format-source" = "";
            "format-source-muted" = "";
            "on-click" = "pavucontrol -t 4";
            "tooltip-format" = "{format_source} {source_desc} // {source_volume}%";
            "scroll-step" = 5;
          };

          "tray" = {
            "icon-size" = 12;
            "spacing" = 5;
          };

          "battery" = {
            "states" = {
              "good" = 95;
              "warning" = 30;
              "critical" = 20;
            };
            "format" = "{icon} {capacity}%";
            "format-charging" = " {capacity}%";
            "format-plugged" = " {capacity}%";
            "format-alt" = "{time} {icon}";
            "format-icons" = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };

          "custom/power" = {
            "format" = "{}";
            "on-click" = "~/.config/hypr/scripts/Wlogout.sh";
            "interval" = 86400; # once every day
            "tooltip" = true;
          };

          # modules for padding

          "custom/l_end" = {
            "format" = " ";
            "interval" = "once";
            "tooltip" = false;
          };

          "custom/r_end" = {
            "format" = " ";
            "interval" = "once";
            "tooltip" = false;
          };

          "custom/sl_end" = {
            "format" = " ";
            "interval" = "once";
            "tooltip" = false;
          };

          "custom/sr_end" = {
            "format" = " ";
            "interval" = "once";
            "tooltip" = false;
          };

	  "custom/logo" = {
	    "format" = " ";
	    "interval" = "once";
	    "tooltip" = false;
	  };

          "custom/rl_end" = {
            "format" = " ";
            "interval" = "once";
            "tooltip" = false;
          };

          "custom/rr_end" = {
            "format" = " ";
            "interval" = "once";
            "tooltip" = false;
          };

          "custom/padd" = {
            "format" = "  ";
            "interval" = "once";
            "tooltip" = false;
          };
        }
      ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      exec-once = [
        "swww init"
        "swww img ~/Wallpapers/wallpaper.png"
        "waybar"
        "dunst"
      ];
      monitor = "..., preferred, auto, auto";
      #env = [ "XCURSOR_SIZE, 24" ];

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

        rounding = 10;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };

      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
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
     EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
