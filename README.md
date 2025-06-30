# Cyber Green Fish Prompt 

A fresh, clean, and personalized terminal prompt

### Requarements
- Any Linux distro (I personally use CachyOS)
- Fish Shell
- fastfetch

### Usage

Backup and remove config
```bash
mkdir -p ~/fish.back 
rm -rf ~/.config/fish
```
Clone 
```bash
git clone https://github.com/Hadi493/cg-fish.git ~/.config/fish/ 
```
source
```bash
source ~/.config/fish/config.fish
```

## ***Please check the `config.fish` file and customize `aliases` according to your*** (default aliases for archlinux)
### Aliases 

For Debian
```bash 
alias sys-upgrade="sudo apt update && sudo apt upgrade -y"
alias apt="sudo apt"
```

For Fedora
```bash
alias sys-upgrade="sudo dnf upgrade -y"
alias dnf="sudo dnf"
```
