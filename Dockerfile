FROM ruby:2.7.2
WORKDIR /app
COPY Gemfile .
COPY Gemfile.lock .
RUN  bundle install 
COPY ./ .

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
