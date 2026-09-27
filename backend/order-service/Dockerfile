FROM node:20-alpine

WORKDIR /app
ENV NODE_ENV=production \
    PORT=3004

# Install only production dependencies (nodemon is a devDependency and not needed)
COPY package*.json ./
RUN npm install --omit=dev && npm cache clean --force

COPY . .

EXPOSE 3004
USER node
CMD ["node", "server.js"]
