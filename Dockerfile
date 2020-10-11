#multi step builds process (using different base images)
#build phase
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
 
 #run phase
FROM nginx
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html


#Can name builder but will fail on AWS
# Ignoring volumes - only applicable for development for hot reloading for prod build it is not applicable
# FROM node:alpine as builder
# WORKDIR '/app'
# COPY package.json .
# RUN npm install
# COPY . .
# RUN npm run build
 
# FROM nginx
# COPY --from=builder /app/build /usr/share/nginx/html