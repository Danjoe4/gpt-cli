#!/bin/sh

install_jq() {
    echo "Please follow install instructions here https://jqlang.github.io/jq/"
    exit 0
}

# If jq is not installed we need to get it
if ! command -v jq > /dev/null 2>&1; then
    install_jq
fi

echo -n "Enter your OpenAI API key: "
read OPENAI_API_KEY

# make sure the key is valid
rc=$(curl -s -o /dev/null -w "%{http_code}" https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d '{
     "model": "gpt-4o-mini",
     "messages": [{"role": "user", "content": "test"}]
 }')
[ $rc -ne 200 ] && echo "invalid key" && exit 1

# retrieve the script and write to it and move it somewhere in $PATH
URL="https://raw.githubusercontent.com/Danjoe4/gpt-cli/master/gpt"
FILE="gpt"
curl -s -o "$FILE" "$URL"
if [ ! -f "$FILE" ]; then
  echo "Failed to download the file."
  exit 1
fi
sed -i "s/^OPENAI_API_KEY=.*/OPENAI_API_KEY=\"${OPENAI_API_KEY}\"/" "$FILE"
mv $FILE /usr/bin/
chmod a+x /usr/bin/$FILE
echo 'All done, use "gpt {prompt}" to use'
