# Toshl Calendar

Get a calendar with all of your recurring [Toshl](https://toshl.com) expenses.

## How to run the application

```
bundle install
bundle exec ruby app.rb
```

## How to use

1. [Create a personal Toshl token](https://developer.toshl.com/apps/) (see why below).
2. Use `/cal?token=YOUR_TOKEN` to get an `ics` file, or use the URL in your Calendar app to add the generated calendar automatically. You can either run the app locally, or use the deployed version at [toshl-calendar.now.sh](https://toshl-calendar.now.sh).

## Why do I need to use a personal token?

At the moment of this writing (February, 2018), the [latest news on Toshl's developers' portal (from April 2016)](https://developer.toshl.com/labs/2016/04/personal-tokens/) mention that a personal token is needed to test the API. The Oauth flow doesn't seem to be available yet.

This isn't ideal since the personal token is allowed to get all data for the user that generated it (there are no scopes), and it's not as straightforward for the end user (instead of a regular "Sign in with Toshl" page, they have to use the developers' portal). But it's all we have for the moment.
