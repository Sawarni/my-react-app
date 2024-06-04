FROM node:latest AS build

WORKDIR /build


COPY package.json package.json


COPY package-lock.json package-lock.json


RUN npm install


COPY public/ public


COPY src/ src


RUN npm run build

FROM nginx:alpine

# Copy the built React app to Nginx's web server directory
COPY --from=build /build/build /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]

# FROM httpd:alpine


# WORKDIR /var/www/html


# COPY --from=build /build/build/ .