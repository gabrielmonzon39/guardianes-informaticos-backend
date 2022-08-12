FROM ruby:3.0.0

RUN apt-get update -qq \
  && apt-get install -y nodejs postgresql-client

WORKDIR /Rails-Docker

COPY ./Gemfile /Rails-Docker/Gemfile
COPY ./Gemfile.lock /Rails-Docker/Gemfile.lock
RUN gem install bundler
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
