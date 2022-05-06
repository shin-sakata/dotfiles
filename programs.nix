# programs ディレクトリの中身を読み取って、
# fileの名前をレコードのキー, fileの中身を値にして返すutil関数
# pkgs, lib をfileの中身に渡す処理も含まれている
{ pkgs, lib }:
let
  # programs ファイルが含まれる path の設定
  programsDirPath = ./programs;
  # programs ファイルに渡したいパラメータの設定
  parameters = { inherit pkgs lib; };

  fileNames = lib.attrsets.mapAttrsToList (name: value: lib.strings.removeSuffix ".nix" name) (builtins.readDir programsDirPath);
  mkField = name: { name = name; value = import /${programsDirPath}/${name}.nix parameters; };
in
builtins.listToAttrs (map mkField fileNames)
