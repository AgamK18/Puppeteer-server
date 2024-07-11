# Use the official Node.js image.
# https://hub.docker.com/_/node
FROM node:latest

# Create and change to the app directory.
WORKDIR /usr/src/app

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY package*.json ./

# Install dependencies.
RUN npm install

# Copy local code to the container image.
COPY . .

# Install Tor
RUN apt-get update && apt-get install -y tor

# Start Tor service
RUN service tor start

# Expose the port the app runs on
EXPOSE 3000

# Run the web service on container startup.
CMD ["sh", "-c", "service tor start && node index.js"]
