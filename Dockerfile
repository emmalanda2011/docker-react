FROM node:alpine as builder

ENV http_proxy 'http://genproxy.corp.amdocs.com:8080'
ENV https_proxy 'http://genproxy.corp.amdocs.com:8080'

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
