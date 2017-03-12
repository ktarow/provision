# provision

This repository is provision for my envirionments by itamae.

# Environment
- Ruby
  - 2.4.0

# Usage

```
$ git clone git@github.com:ktarow/provision.git
$ bundle install --path vendor/bundle
$ bundle exec itamae -h
Commands:
  itamae destroy [cookbook|role] [NAME]   # Undo role or cookbook (short-cut alias: "d")
  itamae docker RECIPE [RECIPE...]        # Create Docker image
  itamae generate [cookbook|role] [NAME]  # Initialize role or cookbook (short-cut alias: "g")
  itamae help [COMMAND]                   # Describe available commands or one specific command
  itamae init NAME                        # Create a new project
  itamae local RECIPE [RECIPE...]         # Run Itamae locally
  itamae ssh RECIPE [RECIPE...]           # Run Itamae via ssh
  itamae version                          # Print version

Options:
  -l, [--log-level=LOG_LEVEL]
                               # Default: info
      [--color], [--no-color]
                               # Default: true
  -c, [--config=CONFIG]
```
