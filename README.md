# ArmB Docker Install

Small helper repository containing a script to install Docker on Armbian-based systems.

## Prerequisites
- An Armbian-based Linux system
- A user with `sudo` or root access
- Internet access

## Files
- `docker-install.sh` — installer script that performs the Docker installation.

## Usage
1. Make the script executable (if necessary):

   chmod +x docker-install.sh

2. Run the installer as root or with `sudo`:

   sudo bash docker-install.sh

If you want verbose output for debugging, run:

   sudo bash -x docker-install.sh

## Notes
- The script modifies system packages and services; review it before running.
- If something fails, examine the console output and syslog for details.

## License
No license specified. Add a LICENSE file if you intend to relicense.
