FROM ruby:3.1.2

USER root
ENV TZ Asia/Tokyo

RUN apt update &&  \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs
RUN npm install -g yarn

RUN mkdir /app
WORKDIR /app

COPY package.json yarn.lock /app/
RUN yarn install

COPY Gemfile Gemfile.lock ./
RUN gem update --system
RUN gem install bundler -v 2.3.16 --no-document
RUN bundle install

COPY . /app

