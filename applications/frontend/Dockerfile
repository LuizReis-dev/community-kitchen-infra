FROM node:22-alpine AS deps

WORKDIR /app

COPY package*.json ./
RUN npm ci

FROM node:22-alpine AS builder

WORKDIR /app

ARG NEXT_PUBLIC_CK_API_URI=""
ARG NEXT_PUBLIC_USER_CONTROLLER_API_URI=""
ARG NEXT_PUBLIC_JWT_SECRET=""

ENV NEXT_PUBLIC_CK_API_URI=$NEXT_PUBLIC_CK_API_URI
ENV NEXT_PUBLIC_USER_CONTROLLER_API_URI=$NEXT_PUBLIC_USER_CONTROLLER_API_URI
ENV NEXT_PUBLIC_JWT_SECRET=$NEXT_PUBLIC_JWT_SECRET

COPY --from=deps /app/node_modules ./node_modules
COPY . .
RUN test -n "$NEXT_PUBLIC_USER_CONTROLLER_API_URI"
RUN npm run build

FROM node:22-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=5000
ENV HOSTNAME=0.0.0.0

COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

EXPOSE 5000

CMD ["npm", "run", "start", "--", "-p", "5000", "-H", "0.0.0.0"]
