FROM ruby:3.3.6

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /app

COPY Gemfile* .

RUN bundle install

COPY . .

EXPOSE 3000

CMD [ "bundle", "exec", "puma", "-C", "config/puma.rb" ]