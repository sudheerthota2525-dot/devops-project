# Simple Nginx-based UI container
FROM nginx:alpine

# Copy static UI files
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
