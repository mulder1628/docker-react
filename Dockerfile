FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build this is the dir we care about from the above step
# the FROM below terminates the previous phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# default nginx container command is start nginx