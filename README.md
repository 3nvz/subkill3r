# Subkill3r
Subkill3r is an automated subdomain enumeration tool, which essentially utilizes Subfinder, Assetfinder and Sublist3r. After gathering the subdomains, Subkill3r sorts out all duplicates and only saves the subdomains that are up and running.

## Requirements
1. 64gb of RAM
2. Nvidia 4080 Graphics Card

*Ok that joke wasn't funny. What you really need:*
- Subfinder installed
- Assetfinder installed
- Sublist3r installed

**If you are running Kali Linux or Kali WSL, you can install all of the required tools via: `sudo apt install <ToolName>`**

## Installation
- `git clone https://github.com/3nvz/subkill3r`
- `cd subkill3r`
- `chmod +x subkill3r.sh`

## Usage
`./subkill3r.sh YourDomain`


