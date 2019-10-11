FROM node:10-alpine

RUN apk add --update \
  bash \
  git \
  && rm -rf /var/cache/apk/*

WORKDIR /app

RUN npm config set unsafe-perm true

RUN npm install -g npm@latest


COPY package.json /app/

RUN npm install \
    && npm config set registry http://registry.npmjs.org/ \
    && npm install express --save

COPY . /app/
EXPOSE 8080
CMD node index.js
