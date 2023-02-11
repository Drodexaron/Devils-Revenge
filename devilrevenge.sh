#!/bin/bash

# Set the maximum number of requests to 30,000
max_requests=30000

# Welcome message
echo -e "\033[1;34mHello, Welcome User!\033[0m"
echo -e "\033[1;34mThis is in beta version join our telegram channel and wait for update version!\033[0m"

# Request range input
echo -e "\033[1;34mEnter the number of requests you want to send (max $max_requests):\033[0m"
read range

# URL input
echo -e "\033[1;34mEnter the URL:\033[0m"
read url

# Check if range is within the max limit
if [ $range -gt $max_requests ]; then
  echo -e "\033[1;31mError: Maximum number of requests exceeded.\033[0m"
  exit 1
fi

# Start sending requests
start_time=$(date +%s)
echo -e "\033[1;32m[~] Sending requests to server!\033[0m"
for i in $(seq 1 $range); do
  # Send request
  response=$(curl -s -o /dev/null -w "%{http_code}" $url)

  # Check if server blocked requests
  if [ $response -ne 200 ]; then
    echo -e "\033[1;31m[~] Server blocked your requests.\033[0m"
    echo -e "\033[1;34mWould you like to restart again? (N/Y):\033[0m"
    read restart
    if [ "$restart" == "Y" ] || [ "$restart" == "y" ]; then
      # Restart sending requests
      continue
    else
      echo -e "\033[1;34mSee you soon!\033[0m"
      exit 0
    fi
  fi
  sleep 1
  echo -e "\033[1;32m[~] Sending requests to server! $(date -u)\033[0m"
done

# Calculate total time
end_time=$(date +%s)
total_time=$((end_time-start_time))

# Display results
echo -e "\033[1;32mFinished sending $range requests.\033[0m"
echo -e "\033[1;32mStarted at: $(date -d @$start_time)\033[0m"
echo -e "\033[1;32mEnded at: $(date -d @$end_time)\033[0m"
echo -e "\033[1;32mTotal time: $total_time seconds\033[0m"
