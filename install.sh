#!/bin/sh

version="1.7.1"

install_jq() {
    echo "Please follow install instructions here https://jqlang.github.io/jq/"
    exit 0
}

# If jq is not installed we need to get it
if ! command -v jq > /dev/null 2>&1; then
    install_jq
fi

read -p "Enter your OpenAI API key: " OPENAI_API_KEY

# make sure the key is valid
rc=$(curl -s -o /dev/null -w "%{http_code}" https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d '{
     "model": "gpt-4o-mini",
     "messages": [{"role": "user", "content": "test"}]
 }')
[ $rc -ne 200 ] && echo "invalid key" && return 1

# retrieve the script and write to it

sed -i "s/^openai_api_key=.*/openai_api_key=\"$openai_api_key\"/" "$FILE"


