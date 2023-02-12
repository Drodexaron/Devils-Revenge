#!/bin/bash

# Welcome message
echo -e "\033[0;32mHello, Welcome User! This is in beta version join our telegram channel and wait for update version!\033[0m"

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
  echo -e "\033[0;31mInvalid input: Requests per second must be a positive integer!\033[0m"
  exit 1
fi

if ! [[ "$time" =~ ^[0-9]+$ ]]; then
  echo -e "\033[0;31mInvalid input: Time must be a positive integer in seconds!\033[0m"
  exit 1
fi

if ! [[ "$use_proxy" =~ ^[NnYy]$ ]]; then
  echo -e "\033[0;31mInvalid input: Use proxy must be either N or Y!\033[0m"
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
