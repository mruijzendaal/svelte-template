# Stage 1: Node with pnpm
FROM node:lts-bullseye-slim AS base
WORKDIR /app
RUN npm install -g pnpm

# Stage 2: Build Stage, install prerequisites
FROM base AS build
COPY package.json pnpm-lock.yaml ./
RUN pnpm install
COPY . .
RUN pnpm run build

# Stage 3: Production Stage
FROM base AS production
WORKDIR /app
COPY --from=build --chown=node:node /app/build ./build
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod
#  Runtime environment
EXPOSE 3000
ENV NODE_ENV=production
ENTRYPOINT [ "node", "build" ]