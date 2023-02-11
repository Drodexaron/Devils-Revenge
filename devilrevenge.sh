#!/bin/bash

# Welcome message
echo -e "\033[34mHello, Welcome User!\033[0m"
echo -e "\033[34mThis is in beta version, join our telegram channel and wait for the update version!\033[0m"

# Request range input
echo -e "\033[34mEnter the range of requests to be sent (max 100):\033[0m"
read range

# URL input
echo -e "\033[34mEnter the URL:\033[0m"
read url

# Loop for sending requests
for i in $(seq 1 $range)
do
  # Sending request message
  echo -e "\033[31m[~]Sending request $i to server!\033[0m \033[32m[$(date +%s%3N) UTC]\033[0m"

  # Send request using curl
  response=$(curl -s -o /dev/null -w "%{http_code}" $url)

  # Check if server blocked the request
  if [ $response -eq 403 ]
  then
    echo -e "\033[31m[~]Server blocked your requests.\033[0m"

    # Restart option
    echo -e "\033[34mWould you like to restart again? (N/Y):\033[0m"
    read restart

    if [ "$restart" == "Y" ] || [ "$restart" == "y" ]
    then
      i=0
    else
      echo -e "\033[34mSee you soon!\033[0m"
      exit 0
    fi
  fi
done

# End message
echo -e "\033[34mFinished sending requests to server.\033[0m"

