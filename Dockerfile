FROM mrvold/rivulet:latest
RUN apk add --no-cache postgresql-dev libpq

WORKDIR /app
COPY Gemfile ./
RUN bundle install

EXPOSE 9292

ENTRYPOINT []
CMD ["bundle", "exec", "falcon", "serve", "-n", "1", "-b", "http://0.0.0.0:9292"]
