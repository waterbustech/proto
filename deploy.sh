#!/bin/bash

# Path to the "packages" directory
proto_dir="../proto"
parent_dir=$(dirname "$PWD")
current_dir="$PWD"

echo $parent_dir

# Check if there are any passed parameters
if [ -z "$1" ]; then
  # No parameters passed, get the path of all sibling directories
  destination_dirs=("$parent_dir"/*)
else
  # Parameter passed, use it as the destination path
  destination_dirs=("../$1")
fi

# Copy the "dist" directory and "package.json" file from the "packages" directory to the destination directories
for destination_dir in "${destination_dirs[@]}"; do
  if [ "$destination_dir" != "$current_dir" ]; then
    echo $destination_dir
    if [ -d "$destination_dir/node_modules/waterbus-proto" ]; then
      rm -rf "$destination_dir/node_modules/waterbus-proto"/*
    else
      mkdir -p "$destination_dir/node_modules/waterbus-proto"
    fi
    cp -r "$proto_dir/dist" "$destination_dir/node_modules/waterbus-proto"
    cp "$proto_dir/package.json" "$destination_dir/node_modules/waterbus-proto"
  fi
done

echo "Deploy completed!"
