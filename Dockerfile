FROM ruby:2.7.1-buster

RUN mkdir /demo_app
WORKDIR /demo_app

RUN gem install bundler -v 2.1.4
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install --retry 3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn -y

COPY package.json yarn.lock ./
COPY ./app/javascript ./app/javascript 
COPY ./app/assets ./app/assets
RUN yarn install --check-files

COPY ./bin ./bin
COPY ./config ./config
RUN bin/webpack

COPY Rakefile Rakefile
RUN rails assets:precompile

COPY . .
