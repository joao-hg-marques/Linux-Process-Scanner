#!/bin/bash

# Insert VirusTotal API key
API_KEY="ADD_YOUR_API_KEY"

# This gets the list of running processes
PROCESSES=$(ps -eo command)

# Initialize counters
total=0
malicious=0
no_malicious=0

# Loop through the processes do loop
while read -r process; do
  # Hash the process using sha256
  hash=$(echo "$process" | sha256sum | awk '{print $1}')

  # It uses VirusTotal API to check the hash
  response=$(curl -s -X POST "https://www.virustotal.com/api/v3/files/$hash/behaviour" \
    -H "x-apikey: $API_KEY")

  # Check the response for the "detected_communicating_samples" field. This will communicate VT and Endpoint (data base for malware analysis.
  detected=$(echo "$response" | jq -r '.data.attributes.detected_communicating_samples | length')

  # Print the process and detection status and prints a report
  if [ "$detected" -gt "0" ]; then
    echo "Process $process is potentially malicious ($detected detections)"
    ((malicious++))
  else
    echo "Process $process is not malicious"
    ((no_malicious++))
  fi
  ((total++))
done <<< "$PROCESSES"

# Print the total number of scanned files
echo "Total number of scanned files: $total"
echo "Number of potentially malicious files: $malicious"
echo "Number of no malicious files: $no_malicious"

