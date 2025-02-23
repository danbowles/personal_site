#!/bin/bash

# Run git subtree split and capture the output hash
HASH=$(git subtree split --prefix output main)

# Check if the command was successful
if [ -z "$HASH" ]; then
  echo "Error: Failed to get subtree split hash."
  exit 1
fi

# Push the hash to the gh-pages branch
echo "Pushing $HASH to origin gh-pages..."
git push origin "$HASH":gh-pages --force
