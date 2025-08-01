#!/usr/bin/bash
app_name=$1
if [ -z "$app_name" ]; then
  echo "Error: Please provide a project name as the first argument."
  exit 1
fi
nvm use 22
npm create vite@latest "./${app_name}"
cd $app_name
npm install
npm install tailwindcss@latest @tailwindcss/cli@latest
touch ./src/style.css ./src/tailwind.css
echo '@import "tailwindcss";' > ./src/tailwind.css
sed -i '/"dev":/a\ \ \ \ "tailwindcss": "npx @tailwindcss/cli -i ./src/tailwind.css -o ./src/style.css --watch",' package.json
 sed -i "s/import '\.\/index\.css'/import '\.\/style\.css'/" ./src/main.jsx
sed -i 's/import .\/App.css/import .\/style.css/' ./src/App.jsx
sed -i "/plugins/a\ server:\{\n\thost:\"0.0.0.0\",\n\tport:3000\}" vite.config.js


