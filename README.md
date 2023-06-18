# Force-RGB-Color-on-M1-M2-Mac-Script
=============

This script is designed to force M1/M2 Macs to use RGB mode on external monitors instead of YPbPr. It performs a series of steps to modify the necessary configuration files.

Tested on M1 Mac Air with 165Hz 1080p monitor.

Prerequisites
-------------

*   Python 3 must be installed on your Mac. You can check if it is installed by running the following command in the terminal:

    `python3 --version`
*   You need administrative privileges to run this script.

Usage
-----

1.  Clone the repository to your local machine:

    `git clone https://github.com/entropyconquers/Force-RGB-Color-on-M1-M2-Mac-Script.git`
    

2.  Navigate to the project directory:

    `cd mac-rgb-force`
    

3.  Give execution permissions to the script:

    `chmod +x mac-rgb-force.sh`
    

4.  Run the script as sudo:

    `sudo ./mac-rgb-force.sh`
    

The script will perform a series of steps to modify the necessary configuration files and force RGB mode on external monitors. It will prompt you for confirmation before restarting the computer.

After the computer restarts, the changes should take effect, and your external monitors should be using RGB mode.

**Note:** If any step fails during the execution of the script, it will display an error message and exit. Please make sure you have met the prerequisites and follow the instructions carefully.

Disclaimer
----------

This script modifies system files, and there is a risk of unintended consequences. Use it at your own risk. The author takes no responsibility for any damages or issues caused by the use of this script.

License
-------

This project is licensed under the [MIT License](LICENSE).