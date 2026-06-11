{ pkgs, ... }:

{
  home.packages = [ pkgs.wofi ];

  xdg.configFile."wofi/config".text = ''
    width=600
    height=400
    location=center
    show=drun
    prompt=Run
    filter_rate=100
    allow_markup=true
    no_actions=true
    halign=fill
    orientation=vertical
    content_halign=fill
    insensitive=true
    allow_images=true
    image_size=32
    gtk_dark=true
  '';

  xdg.configFile."wofi/style.css".text = ''
    window {
      background-color: #1e1e2e;
      color: #cdd6f4;
      border: 1px solid #89b4fa;
      border-radius: 8px;
      font-family: "JetBrainsMono Nerd Font", monospace;
      font-size: 13px;
    }
    #input {
      margin: 8px;
      padding: 6px;
      background-color: #313244;
      color: #cdd6f4;
      border: none;
      border-radius: 6px;
    }
    #inner-box, #outer-box { background-color: #1e1e2e; }
    #entry { padding: 6px 10px; }
    #entry:selected {
      background-color: #45475a;
      border-radius: 6px;
    }
    #text { color: #cdd6f4; }
  '';
}
