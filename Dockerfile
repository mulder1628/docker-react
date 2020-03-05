FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build this is the dir we care about from the above step
# the FROM below terminates the previous phase
FROM nginx
# elastic beanstalk will look for the expose instruction and  use the port to map port from the container
# for our environment, this instruction does nothing
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# default nginx container command is start nginx