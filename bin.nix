{ pkgs }:
let
  # bin ディレクトリのパス
  binDirPath = ./bin;

  # bin ディレクトリ内のファイル名を取得
  fileNames = builtins.attrNames (builtins.readDir binDirPath);

  # ファイル名からスクリプトを生成する関数
  mkScript = name: 
    pkgs.writeShellScriptBin name (builtins.readFile (binDirPath + "/${name}"));
in
  map mkScript fileNames
