FROM ruby:3.1

# Install Node.js and Yarn
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3001

# CMD ["sleep", "infinity"]

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3001"]
