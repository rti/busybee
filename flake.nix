{
  description = "busybee — autonomous dev-loop driven by GitHub issues/PRs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system} = {
        dev-loop = pkgs.writeShellApplication {
          name = "dev-loop";
          runtimeInputs = with pkgs; [
            bash
            git
            gh
            jq
            opencode
          ];
          text = builtins.readFile ./dev-loop.sh;
        };

        default = self.packages.${system}.dev-loop;
      };

      devShells.${system}.default = pkgs.mkShell {
          packages = with pkgs; [
            bash
            git
            gh
            jq
            opencode
            shellcheck
            hugo
          ];
      };
    };
}
