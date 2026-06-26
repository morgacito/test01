# Base stage (dummy/empty to avoid errors if docker-compose references it)
FROM node:20-slim AS base
WORKDIR /app

# Development stage (dummy to satisfy docker-compose targets)
FROM base AS development
EXPOSE 3000
CMD ["echo", "Development target not used in production"]

# Production stage (serves prebuilt static files)
FROM node:20-slim AS production
WORKDIR /app
RUN npm install -g serve
COPY dist ./dist
EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]
