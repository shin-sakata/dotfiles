{ pkgs
, moonbitWasmHash ? "sha256-twNN5qE0fMRD9KKhn1u+4Jr3rUStl4bHb2euKTSjxwI="
, moonRev ? "4a16b422636ddbf3d607452dfc304dff737ae7e2"
, moonHash ? "sha256-Kpo1jjtRthu5tJWKN/PZT2hX5e6TEAxgfltpUrBTXTs="
, moonCargoHash ? "sha256-q4JSBUyWB6Gpp38YEJbSdS9XL+2UgcQ357xxxOvi6Gw="
}:
let
  moon = pkgs.rustPlatform.buildRustPackage {
    pname = "moon";
    version = moonRev;
    src = pkgs.fetchFromGitHub { owner = "moonbitlang"; repo = "moon"; rev = moonRev; hash = moonHash; };
    cargoHash = moonCargoHash;
    nativeBuildInputs = [ pkgs.curl pkgs.python3 pkgs.gzip pkgs.cacert ];
    preBuild = "export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
    doCheck = false;
  };
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "moonbit-wasm-toolchain";
  version = "latest";
  src = pkgs.fetchurl {
    url = "https://github.com/moonbitlang/moonbit-compiler/releases/latest/download/moonbit-wasm.tar.gz";
    hash = moonbitWasmHash;
  };
  dontUnpack = true;
  nativeBuildInputs = [ pkgs.gnutar pkgs.gzip pkgs.nodejs_24 pkgs.clang ];
  installPhase = ''
    mkdir -p $out/{bin,libexec/moonbit,lib,include}
    tar -xzf $src
    cp -r lib include $out/
    cp -r moonc.assets moonfmt.assets mooninfo.assets $out/libexec/moonbit/
    cp moonc.js moonfmt.js mooninfo.js $out/libexec/moonbit/
    cp ${moon}/bin/moon ${moon}/bin/moonrun $out/bin/
    printf '%s\n' "#!${pkgs.runtimeShell}" "exec ${pkgs.nodejs_24}/bin/node --stack-size=4096 $out/libexec/moonbit/moonc.js \"\$@\"" > $out/bin/moonc
    printf '%s\n' "#!${pkgs.runtimeShell}" "exec ${pkgs.nodejs_24}/bin/node --stack-size=4096 $out/libexec/moonbit/moonfmt.js \"\$@\"" > $out/bin/moonfmt
    printf '%s\n' "#!${pkgs.runtimeShell}" "exec ${pkgs.nodejs_24}/bin/node --stack-size=4096 $out/libexec/moonbit/mooninfo.js \"\$@\"" > $out/bin/mooninfo
    chmod +x $out/bin/{moonc,moonfmt,mooninfo}
    tar -xf core.tar.gz -C $out/lib
    export MOON_HOME=$out
    export PATH=$out/bin:$PATH
    (cd $out/lib/core && moon bundle --target all)
  '';
}
