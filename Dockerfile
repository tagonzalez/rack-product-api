FROM ruby:3.2

WORKDIR /app

COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE 9292
