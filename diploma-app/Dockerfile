# Сборка фронта
FROM node:18 AS builder
WORKDIR /app
COPY package.json package.json
RUN npm install
COPY . .
RUN npm run build

# Статический сервер (например, nginx)
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
