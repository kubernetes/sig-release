#!/bin/bash

# Initialize variables
YOUR_USER=""
AUTO_PUSH=false
FUTURE_RELEASE=""

# Help function
help() {
  echo "Usage: $0 FUTURE_RELEASE [-p | --push] [-u | --user USER]"
  echo "Options:"
  echo "  -p, --push    Push the branch sync automatically without prompting"
  echo "  -u, --user    Set the GitHub user that owns the website fork"
  echo "  -h, --help    Display this help message"
}

# Function to print commands in bold and colored text
print_command() {
  echo -e "\033[1;34mExecuting: $1\033[0m"
}

# Function to execute a command and handle errors
execute() {
  print_command "$1"
  eval "$1"
  if [ $? -ne 0 ]; then
    echo -e "\033[1;31mError: Command failed - $1\033[0m"
    exit 1
  fi
}

# Parse command-line options
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -h|--help)
      help
      exit 0
      ;;
    -p|--push)
      AUTO_PUSH=true
      shift
      ;;
    -u|--user)
      YOUR_USER="$2"
      shift
      shift
      ;;
    *)
      FUTURE_RELEASE="$key"
      shift
      ;;
  esac
done

# Ensure a future release argument is provided
if [ -z "$FUTURE_RELEASE" ]; then
  help
  exit 1
fi

# Ensure a GitHub user is provided
if [ -z "$YOUR_USER" ]; then
  echo "Error: Please provide your GitHub user through the -u option or by setting YOUR_USER in branch-sync.sh"
  help
  exit 1
fi

# Refuse to clone over an existing directory
if [ -e website ]; then
  echo -e "\033[1;31mError: A 'website' directory already exists in $(pwd). Remove or rename it and run the script again.\033[0m"
  exit 1
fi

MERGE_MESSAGE="Merge main into dev-$FUTURE_RELEASE to keep in sync"

# Display configuration and prompt user before execution
echo -e "USER: $YOUR_USER"
echo -e "FUTURE_RELEASE: $FUTURE_RELEASE"
echo -e "AUTO_PUSH: $AUTO_PUSH"

echo -e "\033[1;35mDo you want to proceed with these values? (y/n):\033[0m"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then

  # Print received arguments
  print_command "FUTURE_RELEASE: $FUTURE_RELEASE"
  print_command "AUTO_PUSH: $AUTO_PUSH"

  # Clone the repository
  execute "git clone git@github.com:$YOUR_USER/website.git"

  # Change directory to the cloned repository
  execute "cd website"

  # Add the upstream remote and set the push URL to no_push
  execute "git remote add upstream https://github.com/kubernetes/website.git"
  execute "git remote set-url --push upstream no_push"

  # Fetch the upstream main and future release branches
  execute "git fetch upstream main"
  execute "git fetch upstream dev-$FUTURE_RELEASE"

  # Checkout the future release branch tracking upstream
  execute "git checkout --track upstream/dev-$FUTURE_RELEASE"

  # Ensure the branch is up-to-date
  execute "git pull --ff-only"

  # Merge the main branch from upstream, stopping on conflicts
  print_command "git merge upstream/main -m '$MERGE_MESSAGE'"
  if ! git merge upstream/main -m "$MERGE_MESSAGE"; then
    echo -e "\033[1;31mError: Potentially a merge conflict has been detected.\033[0m"
    echo -e "\033[1;32mIf there is a merge conflict, resolve the conflict in the 'website' directory:\033[0m"
    echo -e "\033[1;32m- More on resolving merge conflicts: https://help.github.com/articles/resolving-a-merge-conflict-using-the-command-line/\033[0m"
    echo -e "\033[1;32m- e.g. git add ... and git commit -m '$MERGE_MESSAGE'\033[0m"
    echo -e "\033[1;32m- Then: git checkout -b merged-main-dev-$FUTURE_RELEASE && git push origin merged-main-dev-$FUTURE_RELEASE\033[0m"
    exit 1
  fi

  # Create a new branch for the merged changes
  execute "git checkout -b merged-main-dev-$FUTURE_RELEASE"

  print_pr_instructions() {
    echo -e "\033[1;32mBranch Sync Pushed!\033[0m"
    echo -e "\033[1;33mTo create the PR, go to your fork in a browser: https://github.com/$YOUR_USER/website\033[0m"
    echo -e "\033[1;33mSubmit a PR against upstream 'dev-$FUTURE_RELEASE' from your fork's branch 'merged-main-dev-$FUTURE_RELEASE' by changing the 'base' from 'main' to 'dev-$FUTURE_RELEASE' when creating the PR.\033[0m"
    echo -e "\033[1;33me.g. https://github.com/kubernetes/website/pull/16225\033[0m"
  }

  # Push the new branch to the origin repository
  if [ "$AUTO_PUSH" = true ]; then
    execute "git push origin merged-main-dev-$FUTURE_RELEASE"
    print_pr_instructions
  else
    # Prompt to confirm before pushing to origin
    echo -e "\033[1;35mDo you want to push the changes to origin? (y/n):\033[0m"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
      execute "git push origin merged-main-dev-$FUTURE_RELEASE"
      print_pr_instructions
    else
      echo -e "\033[1;33mChanges were not pushed to origin.\n\033[0m"
      echo -e "You can manually push using the following command:"
      echo -e "\033[0;32mgit push origin merged-main-dev-$FUTURE_RELEASE\033[0m"
    fi
  fi
else
  echo -e "\033[1;31mTerminating...\033[0m"
fi
