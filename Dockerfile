FROM kyma/docker-nodejs-base
MAINTAINER Kyle Mathews "mathews.kyle@gmail.com"

ADD . /app
WORKDIR /app
RUN npm install
ENTRYPOINT ['coffee', 'index.coffee']
