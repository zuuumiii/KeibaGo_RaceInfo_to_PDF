FROM ruby:3.1.4
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm chromium-driver fonts-ipafont-gothic fonts-ipafont-mincho
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN bundle install
RUN npm install
ENV LANG=ja_JP.UTF-8
ENV TZ=Asia/Tokyo
