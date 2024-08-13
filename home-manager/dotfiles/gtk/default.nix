{ 
    pkgs, 
    ... 
}:
{
    gtk = {
        enable = true;
        font.name = "RobotoMono Nerd Font 12";
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.catppuccin-papirus-folders;
        };
        cursorTheme = {
            name = "Numix-Cursor";
            package = pkgs.numix-cursor-theme;
        };
        theme = {
            name = "Catppuccin-GTK-Purple-Dark";
            package = pkgs.magnetic-catppuccin-gtk.override { accent = [ "purple" ]; };
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
    };
}
