FROM ruby:2.5.0

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
RUN bundle install

# Upload source
COPY . $APP_HOME

EXPOSE 4567
ENV RACK_ENV production
CMD ["ruby", "app.rb"]
