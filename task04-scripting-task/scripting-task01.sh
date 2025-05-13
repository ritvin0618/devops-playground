#!/bin/bash


# Send a request to guvi.in and capture the HTTP status code
HTTP_CODE=$(curl -o /dev/null -s -w "%{http_code}" https://guvi.in)


# Print HTTP status code
echo "HTTP status code: $HTTP_CODE"


# Check code and print success/failure
if [[ "$HTTP_CODE" -ge 200 && "HTTP_CODE" -lt 300 ]]; then
	echo "Success: Website is reachable."
else
	echo "Failure: Website returned an error."
fi


