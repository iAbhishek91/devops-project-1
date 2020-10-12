# ---- BASE NODE ----
FROM node:14.1.0-alpine3.10 AS base
# create working directory
RUN mkdir /root/devops
# set working directory
WORKDIR /root/devops
# copy package.json
COPY package.json .


# ---- DEPENDENCIES ----
FROM base AS dependencies
# copy lock file
COPY yarn.lock .
# install all production dependencies
RUN yarn install --production
# copy the prod dependencies
RUN cp -R node_modules prod_node_modules
# install all the dependencies
RUN yarn


# ---- TEST ----
FROM dependencies AS test
# copy the source code
COPY . .
# run lint
RUN yarn test:lint


# ---- BUILD ----
FROM test AS build
# build the project
RUN yarn build


# ---- PRODUCTION ----
FROM base AS release
# copy production node modules from dependencies
COPY --from=dependencies /root/devops/prod_node_modules ./node_modules
# copy public and server from build file
COPY --from=build /root/devops/public ./public
COPY --from=build /root/devops/server.js ./server.js
# expose the port 8080
EXPOSE 8080
# start the app server process
ENTRYPOINT yarn start