# syntax=docker/dockerfile:experimental
FROM node:alpine

WORKDIR /usr/app

# install ssh client and git
RUN apk add --no-cache openssh-client git

# download public key for github.com
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

# clone our private repository
RUN --mount=type=ssh git clone git@github.com:Adrian54549/simpleweb.git /usr/app

RUN npm install

CMD ["npm", "start"]