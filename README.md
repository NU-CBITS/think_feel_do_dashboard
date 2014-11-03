https://moqups.com/#!/edit/michael.wehrley@gmail.com/bfbZNvUJ

# ThinkFeelDoDashboard

[![Build Status](https://travis-ci.org/cbitstech/think_feel_do_dashboard.svg)](https://travis-ci.org/cbitstech/think_feel_do_dashboard) [![security](https://hakiri.io/github/cbitstech/think_feel_do_dashboard/master.svg)](https://hakiri.io/github/cbitstech/think_feel_do_dashboard/master)

This is a rails engine that allows for the CRUDing and Enrolling of participants

### Download
```
git clone https://github.com/cbitstech/?.git [name of folder]
```

## Assumptions

This engine expects there to be a Devise-like API available, and an authenticatable Participant class stored in a participants table.

## Installation

Add to your Gemfile

```
gem 'think_feel_do_dashboard', git: 'git://github.com/cbitstech/think_feel_do_dashboard.git'
```

Then

```
bundle install
```

## Dependencies

ruby: 2.1.2

rails: ~> 4.1.6

jQuery

## Configuration

Application Name: ThinkFeelDoDashboard

Github Repo: https://github.com/cbitstech/?

Production Url:

Staging Url:

Confluence:

## Database initialization/creation

Make sure you are in the top level folder; i.e., think_feel_do_dashboard. Then run:

```
rake app:db:drop app:db:create app:db:migrate
```

## Seeding Database
```
app:seed:with_fixtures
```

## Running tests

After you migrate the database, you may have to update the engine's testing environment
```
rake app:db:test:prepare
```

Because we have combined brakeman, rubocop, and rspec, you can just run the rake command to run everything
```
rake
```
## Services (job queues, cache servers, search engines, etc.)

## Deployment Instructions

### Production

### Staging

## Possible future 'To Dos'