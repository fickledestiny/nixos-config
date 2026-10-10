{ pkgs, ... }:

let
  version = "0.6.6";

  pmx = pkgs.stdenv.mkDerivation {
    pname = "pmx";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/fivetwenty-io/proxmox-cli/releases/download/v${version}/pmx_${version}_linux_amd64.tar.gz";
      hash = "sha256-NJ9tPv6aaFCIBMWWZoP+L44bZ5M81Q5Y8xpKClipBQI=";
    };

    sourceRoot = ".";

    installPhase = ''
      install -Dm755 pmx $out/bin/pmx

      install -Dm644 share/zsh/site-functions/_pmx \
        $out/share/zsh/site-functions/_pmx
      install -Dm644 share/zsh/site-functions/_pve \
        $out/share/zsh/site-functions/_pve
      install -Dm644 share/zsh/site-functions/_pbs \
        $out/share/zsh/site-functions/_pbs
      install -Dm644 share/zsh/site-functions/_pdm \
        $out/share/zsh/site-functions/_pdm

      ln -s $out/bin/pmx $out/bin/pve
      ln -s $out/bin/pmx $out/bin/pbs
      ln -s $out/bin/pmx $out/bin/pdm
    '';

    meta = {
      description = "Proxmox VE, PBS and PDM CLI";
      homepage = "https://github.com/fivetwenty-io/proxmox-cli";
      license = pkgs.lib.licenses.asl20;
      mainProgram = "pmx";
    };
  };

in
{
  home.packages = [
    pmx
  ];
}
