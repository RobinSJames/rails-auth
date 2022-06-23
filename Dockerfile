FROM ruby:3.1.2-slim-buster

RUN apt-get update && apt-get install -y curl gnupg2 build-essential libpq-dev

RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn

RUN mkdir -p /app
WORKDIR /app
RUN gem install rails bundle

COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./
RUN bundle
RUN yarn install

EXPOSE 3000

CMD ["rails", "server"]