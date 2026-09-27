# ---- Build stage: compile the React app ----
FROM node:20-alpine AS build

WORKDIR /app

# Empty service URLs => the app calls relative paths (/api/...), which nginx proxies
ENV REACT_APP_USER_SERVICE_URL="" \
    REACT_APP_PRODUCT_SERVICE_URL="" \
    REACT_APP_CART_SERVICE_URL="" \
    REACT_APP_ORDER_SERVICE_URL="" \
    # No lockfile in repo => newer eslint-plugin-jest breaks CRA's lint step; lint isn't needed for the prod bundle
    DISABLE_ESLINT_PLUGIN=true

COPY package*.json ./
RUN npm install && npm cache clean --force

COPY . .
RUN npm run build

# ---- Runtime stage: serve static files + reverse proxy with nginx ----
FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
