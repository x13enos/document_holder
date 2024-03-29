FROM ruby:3.1.1-alpine

ENV PATH /root/.yarn/bin:$PATH

RUN apk add --no-cache \
  bash \
  git \
  openssh \
  build-base \
  tzdata \
  postgresql-dev \
  shared-mime-info

ENV RAILS_ROOT /var/www/document_holder
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

ADD Gemfile* $RAILS_ROOT/
RUN gem install bundler && bundle install

ADD . $RAILS_ROOT

RUN cp config/database.yml.example config/database.yml

COPY docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]
