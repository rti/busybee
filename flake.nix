{
  description = "busybee — autonomous dev-loop driven by GitHub issues/PRs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      commonDeps = with pkgs; [
        bash
        bash-language-server
        gh
        git
        hugo
        jq
        marksman
        opencode
        playwright-mcp
        shellcheck
        vscode-langservers-extracted
        yaml-language-server
      ];
    in
    {
      packages.${system} = {
        dev-loop = pkgs.writeShellApplication {
          name = "dev-loop";
          runtimeInputs = commonDeps;
          text = builtins.readFile ./dev-loop.sh;
        };

        default = self.packages.${system}.dev-loop;
      };

      devShells.${system}.default = pkgs.mkShell {
          packages = commonDeps;
      };
    };
}
