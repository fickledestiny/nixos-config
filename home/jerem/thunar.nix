{ pkgs, ... }:

{
  home.packages = with pkgs; [
    thunar
    thunar-archive-plugin
    thunar-volman
    xfce.tumbler          # thumbnails
    ffmpegthumbnailer     # video thumbnails
    gvfs                  # trash, network shares, MTP
    loupe                 # image viewer (GNOME)
    glib                  # provides gio, needed for xdg-open/mime launching
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "thunar.desktop";
      "image/jpeg"      = "org.gnome.Loupe.desktop";
      "image/png"       = "org.gnome.Loupe.desktop";
      "image/gif"       = "org.gnome.Loupe.desktop";
      "image/webp"      = "org.gnome.Loupe.desktop";
      "image/tiff"      = "org.gnome.Loupe.desktop";
      "image/bmp"       = "org.gnome.Loupe.desktop";
      "image/svg+xml"   = "org.gnome.Loupe.desktop";
    };
  };
}
