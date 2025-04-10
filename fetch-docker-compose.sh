#!/bin/bash

# Prompt for directory name
read -p "Enter the directory name for the Git repository: " dir_name

# Prompt for repository URL
read -p "Enter the URL of the remote repository: " repo_url

# Prompt for branch name
read -p "Enter the branch name to fetch from: " branch_name

# Prompt for the YML file path (default to docker-compose.yml)
read -p "Enter the path to the YML file to fetch [default: docker-compose.yml]: " yml_file
yml_file=${yml_file:-docker-compose.yml}

# Initialize a new Git repository in the specified directory
git init "$dir_name"

# Navigate into the repository directory
cd "$dir_name" || exit

# Add the remote repository
git remote add origin "$repo_url"

# Enable sparse checkout
git config core.sparseCheckout true

# Specify the file to check out
echo "/$yml_file" > .git/info/sparse-checkout

# Fetch and check out the specific branch with sparse checkout
git fetch origin "$branch_name"
git checkout "$branch_name"
