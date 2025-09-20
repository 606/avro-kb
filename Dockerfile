FROM node:22-slim AS builder
WORKDIR /app
COPY package.json ./
COPY package-lock.json* ./
RUN npm ci

FROM node:22-slim
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
EXPOSE 8080
CMD ["npx", "quartz", "build", "--serve", "--port", "8080"]
