# programs ディレクトリの中身を読み取って良い感じのレコードにしてくれる関数
{ pkgs, lib }:
let
  # ./programs/ 配下のファイルの .nix suffix を削除したリスト
  fileNames = lib.attrsets.mapAttrsToList (name: value: lib.strings.removeSuffix ".nix" name) (builtins.readDir ./programs);
  mkField = name: { name = name; value = import ./programs/${name}.nix { inherit pkgs lib; };};
in
builtins.listToAttrs (map mkField fileNames)
