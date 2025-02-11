{
  description = "Python tool to track aya bounties. Ported to linux.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
  flake-utils.lib.eachDefaultSystem (
    system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.default = pkgs.mkShell {
        packages = [
          (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
            certifi
            cffi
            charset-normalizer
            requests
            urllib3
            pyttsx3
	    tkinter
          ]))
          pkgs.espeak
          pkgs.ffmpeg
        ];
      };
    }
  );
}
