# Fish Shell Configuration

This directory contains my personal Fish shell configuration files.

## Structure

- `config.fish` - Main configuration file with core settings
- `conf.d/nix.fish` - Nix package manager integration
- `README.md` - This documentation file

## Features

- Custom prompt with username, hostname, and directory path
- Virtual environment indicator in prompt
- SSH agent configuration
- Flutter and Ruby paths
- Custom greeting message
- Useful aliases:
  - `ll` for `ls -la`

## Environment Setup

The configuration includes:
- PATH modifications for Flutter
- Ruby gems path configuration
- SSH agent autostart
- Nix package manager integration

## Prompt

The custom prompt includes:
- Username and hostname
- Current directory
- Virtual environment indicator (when active)
- Cyan/green/yellow color scheme
