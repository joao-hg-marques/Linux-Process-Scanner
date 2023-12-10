# Linux-Process-Scanner
This script scans all Linux processes, uses an Virus Total API and determining if Linux processes running on you Linux devices are malicious or not. 

This script will run if Python3 is installed. The jq library must be included. If Python3 and jq library are not installed, follow the following steps:

Install Python3:
sudo apt update
sudo apt install python3

Install jq library:
sudo apt install jq

Make sure curl command is installed. If it is not installed run this command:
sudo apt install curl

Set file permissions by running this command:
chmod +x processcanner.sh
