#!/usr/bin/env bash

set -e

echo "🔧 Recreating .env files from .env.example..."

if [ -f ".env.example" ]; then
    if [ -f ".env" ]; then
        echo "🗑 Removing existing .env"
        rm .env
    fi

    echo "Creating .env from .env.example"
    cp .env.example .env
else
    echo "⚠️ No .env.example found in root"
fi


ENV_DIR="./envs"

if [ -d "$ENV_DIR" ]; then
    for example_file in "$ENV_DIR"/*.env.example; do
        [ -e "$example_file" ] || continue

        target_file="${example_file%.example}"

        if [ -f "$target_file" ]; then
            echo "🗑 Removing existing $target_file"
            rm "$target_file"
        fi

        echo "Creating $target_file from $example_file"
        cp "$example_file" "$target_file"
    done
else
    echo "⚠️ No ./envs directory found"
fi

echo "✅ Done!"