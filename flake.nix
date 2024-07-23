{
  description = "";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    { self, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; }

      {
        systems = [
          "aarch64-darwin"
          "aarch64-linux"
          "x86_64-darwin"
          "x86_64-linux"
        ];

        perSystem =
          {
            config,
            lib,
            system,
            pkgs,
            ...
          }:
          {
            # For standardised reproducible formatting with `nix fmt`
            formatter = pkgs.nixfmt-rfc-style;

            packages = {
              default = pkgs.callPackage ({lib, runCommand}: runCommand "foo" {} ''
              mkdir $out
              cp -r emacs-copilot $out
              ''
              ) {};
            };
          };
      };
}
