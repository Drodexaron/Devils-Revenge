#!/bin/bash

# Welcome message
echo -e "\033[0;32mHello, Welcome User! This is in beta version join our telegram channel and wait for update version!\033[0m"

# Check if curl and jq are installed if ! command -v curl > /dev/null 2>&1 || ! command -v jq > /dev/null 2>&1; then echo -e "\033[0;31mError: curl and jq are required to run this script.\033[0m" echo -e "\033[0;34mDo you want to install them now? (Y/N)\033[0m" read install_reqs if [[ "$install_reqs" =~ ^[Yy]$ ]]; then # Install requirements if command -v apt-get > /dev/null 2>&1; then sudo apt-get update sudo apt-get install -y curl jq elif command -v yum > /dev/null 2>&1; then sudo yum update sudo yum install -y curl jq else echo -e "\033[0;31mError: Package manager not supported. Please install curl and jq manually.\033[0m" exit 1 fi else exit 1 fi fi

# Explain the meaning of every input
echo -e "\033[0;34mHow many requests do you want to send per second?\033[0m"
read requests_per_second
echo -e "\033[0;34mHow many seconds or minutes or hours do you want to send requests for? (Enter in seconds)\033[0m"
read time
echo -e "\033[0;34mWhat is the URL or IP address of the server you want to send requests to?\033[0m"
read url
echo -e "\033[0;34mDo you want to use a proxy while sending requests? (N/Y)\033[0m"
read use_proxy

# Error handling for invalid input
if ! [[ "$requests_per_second" =~ ^[0-9]+$ ]]; then
  echo -e "\033[0;31mError: Requests per second must be a positive integer! Please try again.\033[0m"
  exit 1
fi

if ! [[ "$time" =~ ^[0-9]+$ ]]; then
  echo -e "\033[0;31mError: Time must be a positive integer in seconds! Please try again.\033[0m"
  exit 1
fi

if ! [[ "$use_proxy" =~ ^[NnYy]$ ]]; then
  echo -e "\033[0;31mError: Use proxy must be either N or Y! Please try again.\033[0m"
  exit 1
fi

# Sending requests to the server
start_time=$(date +%s)
end_time=$((start_time + time))
while [[ $(date +%s) -lt $end_time ]]; do
  for i in $(seq 1 "$requests_per_second"); do
    echo -e "[~] \033[0;32mSending requests to server $url! $(date +"%T UTC %Z")\033[0m"
    # Insert your request command here

    # Error handling for server down
    if [[ "$(curl -I $url 2>/dev/null | head -n 1 | cut -d$' ' -f2)" != "200" ]]; then
      echo -e "\033[0;31m[~] Server down!\033[0m"
      while [[ "$(curl -I $url 2>/dev/null | head -n 1 | cut -d$' ' -f2)" != "200" ]]; do
        sleep 1
        echo -e "\033[0;31m[~] Server down!\033[0m"
      done
      echo -e "\033[0;32m[~] Server back online!\033[0m"
    fi
  done
  sleep 1
done

# Alert message for end of requests
echo -e "\033[0;32mFinished sending requests to server $url.\033[0m"

# Function to display a message in red
 function display_error { echo -e "\033[31m$1\033[0m" } # Function to display a message in blue function display_info { echo -e "\033[34m$1\033[0m" } # Check the CPU temperature cpu_temp=$(cat /sys/class/thermal/thermal_zone0/temp) # If the temperature is too hot if [ "$cpu_temp" -gt 70000 ]; then display_error "Your CPU is too hot!" display_info "The current temperature is: $((cpu_temp/1000))°C" display_info "Please take some measures to cool down your device:" display_info "1. Make sure there is proper ventilation." display_info "2. Reduce the load on your CPU by closing some applications." display_info "3. If possible, remove any dust or debris from the fan." exit 1 else display_info "Your CPU temperature is okay." fi
