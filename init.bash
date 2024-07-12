#!/bin/bash

# Initialize npm and create package.json
npm init -y

# Install dependencies
npm install express react react-dom concurrently

# Set up project structure
mkdir backend frontend
cd backend
echo "const express = require('express');" > server.js
echo "const app = express();" >> server.js
echo "const PORT = process.env.PORT || 3000;" >> server.js
echo "" >> server.js
echo "app.use(express.static('../frontend/build'));" >> server.js
echo "" >> server.js
echo "app.listen(PORT, () => {" >> server.js
echo "    console.log(\`Server is running on port \$\{PORT\}\`);" >> server.js
echo "});" >> server.js
cd ..

# Initialize React app
npx create-react-app frontend

# Add scripts to package.json
jq '.scripts += {"start": "node backend/server.js", "client": "npm start --prefix frontend", "dev": "concurrently \\"npm run start\\" \\"npm run client\\""}' package.json > temp.json && mv temp.json package.json

echo "Initialization complete."

chmod +x init.bash

./init.bash
