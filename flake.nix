{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , utils
    }:
    utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      with pkgs; {
        devShells.default = mkShell {
          packages = [
            nodejs
            nodePackages.pnpm
            nodePackages.typescript

            emmet-ls
            nodePackages.svelte-language-server
            nodePackages.typescript-language-server
            nodePackages."@tailwindcss/language-server"
          ];
        };

        formatter = nixpkgs-fmt;
      });
}
