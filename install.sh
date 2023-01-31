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

cp .env.example .env

# Install the dependencies
echo "Installing the dependencies..."
npm install

# Copy the service file
echo "Copying the service file..."
sudo cp chatgpt.service /etc/systemd/system/

# Prompt user to input API key
read -r "Enter API key: " api_key

# Replace OPENAI_API_KEY in .env with user's input
sed -i "s/OPENAI_API_KEY=''/OPENAI_API_KEY='$api_key'/g" .env

# Prompt user to input bot name
read -r "Enter bot name: " bot_name

# Replace botName in config.js with user's input
sed -i "s/export const botName = ''/export const botName = '$bot_name'/g" src/config.js

# Prompt user to input room white list
read -r "Enter room white list (format: 'A','B'): " room_white_list

# Replace roomWhiteList in config.js with user's input
sed -i "s/export const roomWhiteList = \[\]/export const roomWhiteList = \[$room_white_list\]/g" src/config.js

# Prompt user to input alias white list
read -r "Enter alias white list (format: 'A','B'): " alias_white_list

# Replace aliasWhiteList in config.js with user's input
sed -i "s/export const aliasWhiteList = \[\]/export const aliasWhiteList = \[$alias_white_list\]/g" src/config.js


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
