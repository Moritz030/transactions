ARG RUBY_VERSION=3.3.5

FROM ruby:$RUBY_VERSION-slim as transactions

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client

WORKDIR /transactions

ADD Gemfile* ./

RUN gem install bundler

RUN bundle install

ADD . ./