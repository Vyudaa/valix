#! /usr/bin/env bash

nix --experimental-features "nix-command flakes" $1 $2 $3
