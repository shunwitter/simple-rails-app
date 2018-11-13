FROM ruby:2.4.1

MAINTAINER @shunwitter

ENV APP_HOME /var/www
ENV SRC_PATH /usr/local/src
ENV GEM_PATH /bundle
ENV BUNDLE_PATH /bundle/ruby/2.4.0
ENV NODE_VERSION 10.13.0

RUN apt-get update -qq && \
    apt-get install -y build-essential libxml2-dev libxslt1-dev \
                       libmagickcore-dev libmagickwand-dev imagemagick && \
    rm -rf /var/lib/apt/lists/*

RUN gem install -i $GEM_PATH -n $GEM_PATH/bin nokogiri -v '1.6.6.2'
RUN gem install bundler
RUN cd $SRC_DIR && \
    wget http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz && \
    tar -C /usr/local --strip-components 1 -xzf node-v$NODE_VERSION-linux-x64.tar.gz && \
    rm node-v$NODE_VERSION-linux-x64.tar.gz

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

