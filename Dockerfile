# Build Phase (just want build file from npm run build)
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run Phase
FROM nginx
EXPOSE 80
# get only result from Build Phase that we named builder where /app/build 
# from nginx of docker hub docs that tell us where have to place static html(/usr/share/nginx/html)
COPY --from=builder /app/build /usr/share/nginx/html
