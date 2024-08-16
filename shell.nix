# vim: se ts=2 sw=2 et

{ pkgs, ... }:

let
  godot-4_3 = pkgs.godot_4.overrideAttrs rec {
    version = "4.3-stable";
    commitHash = "77dcf97d82cbfe4e4615475fa52ca03da645dbd8";

    src = pkgs.fetchFromGitHub {
      owner = "godotengine";
      repo = "godot";
      rev = commitHash;
      hash = "sha256-v2lBD3GEL8CoIwBl3UoLam0dJxkLGX0oneH6DiWkEsM=";
    };

    preConfigure = ''
      mkdir -p .git
      echo ${commitHash} > .git/HEAD
    '';
  };

in

pkgs.mkShell {
  packages = [
    godot-4_3
    pkgs.inkscape
  ];

  env = { };

  shellHook = ''
  '';
}
