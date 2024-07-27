# Install

```
sudo sh -c "$(curl -s -L https://raw.githubusercontent.com/Danjoe4/gpt-cli/master/install.sh)"
```

# Motivation

To create a super-minimal, POSIX compliant shell script for dead-simple ChatGPT interactions.

## Usage

`gpt say hi gpt!`

## Limitations

Shell has very limited options for safely handling special characters, so avoid using them in your prompts. If you want a more robust solution, use one of the python-based CLI tools.

## Dependencies
https://jqlang.github.io/jq/download/
