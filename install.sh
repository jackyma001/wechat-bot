#!/bin/bash

# Check if node.js is installed, if not, install the latest version
if command -v node &>/dev/null; then
  echo "Node.js is installed"
else
  echo "Node.js is not installed, installing the latest version..."
  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi

# Clone the wechat-bot repository
echo "Cloning the wechat-bot repository..."
git clone https://github.com/jackyma001/wechat-bot.git
cd wechat-bot

# Ask the user for API key
echo "Enter your API key:"
read api_key

# Replace the API key in .env
sed -i "s/OPENAI_API_KEY=.*/OPENAI_API_KEY='$api_key'/" .env

# Ask the user for bot name
echo "Enter your bot name:"
read bot_name

# Replace the bot name in config.js
sed -i "s/export const botName = .*/export const botName = '$bot_name'/" config.js

# Ask the user for room white list
echo "Enter the room white list, separated by commas (e.g. 'A','B'):"
read room_white_list

# Replace the room white list in config.js
sed -i "s/export const roomWhiteList = .*/export const roomWhiteList = [$room_white_list]/" config.js

# Ask the user for alias white list
echo "Enter the alias white list, separated by commas (e.g. 'A','B'):"
read alias_white_list

# Replace the alias white list in config.js
sed -i "s/export const aliasWhiteList = .*/export const aliasWhiteList = [$alias_white_list]/" config.js

# Install the dependencies
echo "Installing the dependencies..."
npm install

# Copy the service file
echo "Copying the service file..."
sudo cp chatgpt.service /etc/systemd/system/

# Reload the system manager configuration
sudo systemctl daemon-reload

# Start the service
echo "Starting the service..."
sudo systemctl start chatgpt

# Enable the service to start on boot
sudo systemctl enable chatgpt

# Show the service status
sudo systemctl status chatgpt

echo "Installation complete!"
