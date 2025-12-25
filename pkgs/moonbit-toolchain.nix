{ pkgs
, moonbitVersion ? "latest"
, moonbitToolchainHash ? "sha256-RyFqCdn0L9vQn+MNJb+5OLGLvCKnHa5R29QFC2/MiT0="
, moonbitCoreHash ? "sha256-huVVqoNtwY/sTwC/J8kjXYVhgpMiNQ2dy5jxDTcikAE="
}:
let
  # NOTE: ファイル名は互換性のため据え置きつつ、実体は公式 CLI toolchain 方式に移行しています。
  target =
    if pkgs.stdenv.hostPlatform.isDarwin && pkgs.stdenv.hostPlatform.isAarch64 then
      "darwin-aarch64"
    else if pkgs.stdenv.hostPlatform.isDarwin && pkgs.stdenv.hostPlatform.isx86_64 then
      "darwin-x86_64"
    else if pkgs.stdenv.hostPlatform.isLinux && pkgs.stdenv.hostPlatform.isx86_64 then
      "linux-x86_64"
    else
      throw "Unsupported platform: ${pkgs.stdenv.hostPlatform.system}";
in
pkgs.stdenvNoCC.mkDerivation {
  pname = "moonbit-toolchain";
  version = moonbitVersion;

  moonbitSrc = pkgs.fetchurl {
    url = "https://cli.moonbitlang.com/binaries/${moonbitVersion}/moonbit-${target}.tar.gz";
    hash = moonbitToolchainHash;
  };

  coreSrc = pkgs.fetchurl {
    url = "https://cli.moonbitlang.com/cores/core-${moonbitVersion}.tar.gz";
    hash = moonbitCoreHash;
  };

  dontUnpack = true;
  nativeBuildInputs = [
    pkgs.gnutar
    pkgs.gzip
    pkgs.makeWrapper
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out"
    tar -xzf "$moonbitSrc" -C "$out"

    mkdir -p "$out/lib"
    tar -xzf "$coreSrc" -C "$out/lib"

    export MOON_HOME="$out"
    export PATH="$out/bin:$PATH"

    # `cli.moonbitlang.com` の tarball では実行バイナリに実行権限が付いていないことがあるため、
    # Nix store へ展開した後に明示的に付与する。
    chmod +x \
      "$out/bin/moon" \
      "$out/bin/moonrun" \
      "$out/bin/moonc" \
      "$out/bin/moonfmt" \
      "$out/bin/mooninfo" \
      "$out/bin/moondoc" \
      "$out/bin/mooncake" \
      "$out/bin/moonbit-lsp" \
      "$out/bin/moon-ide" \
      "$out/bin/moon-pilot" \
      "$out/bin/moon_cove_report" \
      "$out/bin/internal/tcc"
    if [ -d "$out/bin/internal/moon-pilot/bin" ]; then
      chmod +x "$out/bin/internal/moon-pilot/bin/"* || true
    fi

    moon bundle --warn-list -a --all --source-dir "$out/lib/core"
    moon bundle --warn-list -a --target wasm-gc --source-dir "$out/lib/core" --quiet

    wrapProgram "$out/bin/moon" \
      --set-default MOON_HOME "$out"
    wrapProgram "$out/bin/moonrun" \
      --set-default MOON_HOME "$out"

    runHook postInstall
  '';
}

