{
  inputs = {
    nextflow.url = github:IllustratedMan-code/nextflowFlake;
  };

  outputs = {self, nextflow, nixpkgs, ...}:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs{ inherit system;};
    in
      {
      packages.${system}.default = with pkgs; stdenv.mkDerivation {
        name = "nextflow_env";
        buildInputs = [ nextflow.packages."${system}".default ];
      };

  };
}
