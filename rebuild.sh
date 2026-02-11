#!/usr/bin/env bash
set -euo pipefail

CONFIG_DIR="$HOME/.config/nixos"
NIXOS_LOG_FILE="$CONFIG_DIR/rebuild.log"

TARGET="$1"
UPDATE_FLAKES=false
VERBOSE=false
PUSH=true
BOOT=false

Help()
{
    echo "NixOS rebuild script."
    echo
    echo "Syntax: $0 <target> [-u] [-v] [-b] [--no-push]"
    echo "options:"
    echo "u             Update flakes: updates the flakes in nix configuration."
    echo "v             Verbose output: show build logs in the terminal."
    echo "-b            Boot: Use 'nixos-rebuild boot' instead of 'nixos-rebuild switch'."
    echo "--no-push     No Push: Do not push changes to the repository."
    echo
}

TEMP=$(getopt -o uvb --long no-push -n "$0" -- "$@")
if [ $? != 0 ]; then
    echo "Error in arguments" >&2
    Help
    exit 1
fi
eval set -- "$TEMP"

while true; do
  case "$1" in
    -u)
      UPDATE_FLAKES=true
      shift
      ;;
    -v)
      VERBOSE=true
      shift
      ;;
    -b)
      BOOT=true
      shift
      ;;
    --no-push)
      PUSH=false
      shift
      ;;
    --)
      shift
      break
      ;;
    *)
      Help
      exit 1
      ;;
  esac
done

pushd "$CONFIG_DIR" > /dev/null

git stash push -u -m "Auto-stash before rebase"
git pull --rebase
git stash pop || true

git diff -U0 --color=always *.nix || true

git ls-files --others --exclude-standard | xargs -r git add

if [ "$UPDATE_FLAKES" = true ]; then
    echo "Updating flake inputs..."
    nix flake update --extra-experimental-features "nix-command flakes" --accept-flake-config > /dev/null
fi

echo "NixOS Rebuilding for $TARGET..."

if $BOOT; then
    REBUILD="nixos-rebuild boot"
else
    REBUILD="nixos-rebuild switch"
fi

if $VERBOSE; then
    sudo $REBUILD --upgrade --flake "$CONFIG_DIR#$TARGET" --accept-flake-config 2>&1 | tee "$NIXOS_LOG_FILE"
    REBUILD_EXIT_STATUS=${PIPESTATUS[0]}
else
    sudo $REBUILD --upgrade --flake "$CONFIG_DIR#$TARGET" --accept-flake-config &> "$NIXOS_LOG_FILE"
    REBUILD_EXIT_STATUS=$?
fi

if [ $REBUILD_EXIT_STATUS -ne 0 ]; then
    echo "Rebuild failed. "
    if ! $VERBOSE; then
        echo "Showing errors:"
        grep --color -i -A3 "error" "$NIXOS_LOG_FILE" || cat "$NIXOS_LOG_FILE"
    fi
    exit 1
else
    echo "Rebuild successful!"
fi

if ! git diff --quiet; then
    gen=$(nixos-rebuild list-generations | awk '/Generation/{getline; print $1}')
    git commit -am "NixOS Generation: $TARGET $gen"
    if [ "$PUSH" = true ]; then
        git push
        echo "Changes pushed!"
    else
        echo "Changes commited but not pushed."
    fi
else
    echo "No new changes to commit."
    if git rev-list --quiet HEAD@{upstream}..HEAD; then
        if [ "$PUSH" = true ]; then
            git push
            echo "Unpushed commits pushed!"
        else
            echo "Unpushed commits exist but not pushed."
        fi
    fi
fi

popd > /dev/null
