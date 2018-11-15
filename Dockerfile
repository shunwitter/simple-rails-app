FROM ruby:2.4.1

MAINTAINER @shunwitter

ENV APP_HOME /var/www
ENV SRC_PATH /usr/local/src
ENV GEM_PATH /bundle
ENV BUNDLE_PATH /bundle/ruby/2.4.0
ENV NODE_VERSION 10.13.0

RUN apt-get update -qq && \
    apt-get install -y build-essential vim zip wget apt-utils apt-transport-https libxml2-dev libxslt1-dev \
                       libmagickcore-dev libmagickwand-dev imagemagick ocaml libelf-dev libgtk2.0-0 && \
    rm -rf /var/lib/apt/lists/*

RUN gem install -i $GEM_PATH -n $GEM_PATH/bin nokogiri -v '1.6.6.2'
RUN gem install bundler

# Node JS
RUN cd $SRC_DIR && \
    wget http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz && \
    tar -C /usr/local --strip-components 1 -xzf node-v$NODE_VERSION-linux-x64.tar.gz && \
    rm node-v$NODE_VERSION-linux-x64.tar.gz

# For Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    apt-get update && apt-get install -y google-chrome-stable

# Japanese fonts
RUN cd $SRC_DIR && \
  wget http://dl.ipafont.ipa.go.jp/IPAexfont/IPAexfont00301.zip && \
  unzip IPAexfont00301.zip && rm IPAexfont00301.zip && \
  mkdir -p /usr/share/fonts/japanese/TrueType && \
  mv IPAexfont00301/*.ttf /usr/share/fonts/japanese/TrueType/ && fc-cache -fv

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

