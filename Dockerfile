FROM ruby:2.6-buster

LABEL maintainer="Kris Dekeyser <kris.dekeyser@libis.be>"

RUN mkdir /app \
    && gem update --system \
    && gem uninstall bundler \
    && gem install bundler -v 2.1.4

WORKDIR /app
COPY . /app
RUN bundle install

ENV GEMSERVER_USER="" \
    GEMSERVER_PASS=""

EXPOSE 9292

ENTRYPOINT ["puma"]
