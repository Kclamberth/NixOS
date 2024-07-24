{ config, pkgs, ... }:

let
  custom = rec {
    font = "RobotoMono Nerd Font";
    fontsize = "12";
    primary_accent = "cba6f7";
    secondary_accent = "89b4fa";
    tertiary_accent = "f5f5f5";
    background = "11111B";
    opacity = ".85";
    cursor = "Numix-Cursor";
    palette = {
      primary_accent_hex = "cba6f7";
      secondary_accent_hex = "89b4fa";
      tertiary_accent_hex = "f5f5f5";
      primary_background_hex = "11111B";
      secondary_background_hex = "1b1b2b";
      tertiary_background_hex = "25253a";

      primary_accent_rgba = "rgba(203,166,247,${opacity})";
      secondary_accent_rgba = "rgba(137,180,250,${opacity})";
      tertiary_accent_rgba = "rgba(245,245,245,${opacity})";
      primary_background_rgba = "rgba(17,17,27,${opacity})";
      secondary_background_rgba = "rgba(27,27,43,${opacity})";
      tertiary_background_rgba = "rgba(37,37,58,${opacity})";
    };
  };
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      "$mainMod" = "ALT";
      monitor = [
        # name,resolution,position,scale
        # position can be negative to swtich monitor to the left or right side
        # "DP-2,2560x1440@144,0x0,1"
        # "HDMI-0,1920x1080@60,2560x0,1"
	",preferred,auto,1"
      ];
      exec-once = [
        "swww-daemon"
        "swww img ~/.config/home-manager/Wallpapers/wallpaper.png"
        "waybar"
        "dunst"
      ];
      xwayland = {
        force_zero_scaling = true; 
      };
      input = {
        kb_layout = "us";
        follow_mouse = true;
        force_no_accel = 1;
        touchpad = {
          natural_scroll = 1;
        };
      };
      general = {
        gaps_in = 4;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgb(${custom.primary_accent})";
        "col.inactive_border" = "rgba(${custom.background}00)";
        allow_tearing = true;
        layout = "dwindle";
      };
      decoration = {
        rounding = 10;
        shadow_ignore_window = true;
        drop_shadow = true;
        shadow_range = 50;
        shadow_render_power = 3;
        # "col.shadow" = "rgb(${custom.primary_accent})";
        "col.shadow" = "rgba(${custom.primary_accent}00)";
        "col.shadow_inactive" = "rgba(${custom.background}00)";
        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
          ignore_opacity = true;
          noise = 0.0117;
          contrast = 1.2;
          xray = false;
          brightness = 1;
        };
      };
      animations = {
        enabled = true;
        bezier = [ "easeinoutsine, 0.37, 0, 0.63, 1" ];
        animation = [ 
          "windows,1,2,easeinoutsine,slide" 
          "border,1,10,default"
          "fade,1,1,default"
          "workspaces,1,2,easeinoutsine,slide"
        ];
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };
      master = {
        new_is_master = true;
      };
      gestures = {
        workspace_swipe = false;
      };
      misc = {
        vrr = 1;
        disable_hyprland_logo  = true;
        disable_splash_rendering = true;
      };

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      bind = [
        "$mainMod SHIFT, RETURN, exec, kitty"
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        "$mainMod SHIFT, C, killactive,"
        "$mainMod SHIFT, Q, exit,"
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
      windowrulev2 = [
        # "opacity ${custom.opacity} ${custom.opacity},class:^(thunar)$"
        # "opacity ${custom.opacity} ${custom.opacity},class:^(WebCord)$"
        # "opacity ${custom.opacity} ${custom.opacity},class:^(WebCord)$"
        # "opacity 0.90 0.90,class:^(Brave-browser)$"
        # "opacity 0.90 0.90,class:^(brave-browser)$"
        # "opacity 0.90 0.90,class:^(firefox)$"
        "float,class:^(pavucontrol)$"
        "float,class:^(file_progress)$"
        "float,class:^(confirm)$"
        "float,class:^(dialog)$"
        "float,class:^(download)$"
        "float,class:^(notification)$"
        "float,class:^(error)$"
        "float,class:^(confirmreset)$"
        "float,title:^(Open File)$"
        "float,title:^(branchdialog)$"
        "float,title:^(Confirm to replace files)$"
        "float,title:^(File Operation Progress)$"
        "float,title:^(mpv)$"
        # Ensure tearing for specific games
        # All games run with gamescope
        "immediate, class:^(.gamescope-wrapped)$" 
      ];
      layerrule = [
        "blur, waybar"
        "blur, rofi"
        "ignorezero, rofi"
      ];
    };
    # Submaps
    extraConfig = ''
      # will switch to a submap called resize
      bind=$mainMod,R,submap,resize

      # will start a submap called "resize"
      submap=resize

      # sets repeatable binds for resizing the active window
      binde=,L,resizeactive,15 0
      binde=,H,resizeactive,-15 0
      binde=,K,resizeactive,0 -15
      binde=,J,resizeactive,0 15

      # use reset to go back to the global submap
      bind=,escape,submap,reset 
      bind=$mainMod,R,submap,reset

      # will reset the submap, meaning end the current one and return to the global one
      submap=reset

      # For tearing
      env = WLR_DRM_NO_ATOMIC,1
      env = __NV_PRIME_RENDER_OFFLOAD,1 
      env = __VK_LAYER_NV_optimus,NVIDIA_only
    '';
  };
}
