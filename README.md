# ThinkFeelDoDashboard

[![Build Status](https://travis-ci.org/cbitstech/think_feel_do_dashboard.svg)](https://travis-ci.org/cbitstech/think_feel_do_dashboard) [![security](https://hakiri.io/github/cbitstech/think_feel_do_dashboard/master.svg)](https://hakiri.io/github/cbitstech/think_feel_do_dashboard/master)

This is a rails engine that allows for the CRUDing and Enrolling of participants, the CRUDing of users and their roles, groups, assigning coaches to participants and assigning participants to groups, and assiging moderators to groups (and thus indirectly arms).

## Mockups

[Membership & Enrollment Mockups](https://moqups.com/#!/edit/michael.wehrley@gmail.com/bfbZNvUJ)

### Download
```console
git clone https://github.com/cbitstech/think_feel_do_dashboard.git [name of folder]
```

## Assumptions

This engine expects there to be multiple models:

1. Participant: a Devise-like API available and an authenticatable Participant class stored in a participants table;
2. Group: a Group class stored in the groups table and has a title:string
3. Membership: a Membership class that stores a group_id:integer and participant_id:integer in the memberships table. Each membership as a start_date:date and end_date:date that determines if the participant [membership] is active
4. User: a Devise-like API available and an authenticatable User class stored in a users table but referred to as coaches;
5. CoachAssignment: a CoachAssignment class that stores the participant:integer and user_id:integer in the coach_assignments table;

## Installation

Update your `Gemfile`:

```ruby
gem 'think_feel_do_dashboard', git: 'git://github.com/cbitstech/think_feel_do_dashboard.git'
```

Update gems:

```console
bundle install
```

Add the routes by configuring your `routes.rb` file:

```ruby
Rails.application.routes.draw do
  ...
  mount ThinkFeelDoDashboard::Engine => "think_feel_do_dashboard"
  ...
end
```

Note: You will have access to additional routes.

1. home: `/think_feel_do_dashboard`
2. projects: `/think_feel_do_dashboard/projects`
3. arms: `/think_feel_do_dashboard/arms`
4. groups: `/think_feel_do_dashboard/groups`
5. participants: `/think_feel_do_dashboard/participants`
6. memberships: `/think_feel_do_dashboard/participants/1/groups`
7. coach_assignments: `/think_feel_do_dashboard/participants/1/coaches`

Add the appropriate password concern to the `app/models/user.rb` file:

```ruby
class User < ActiveRecord::Base
  include ThinkFeelDoDashboard::Concerns::Password
  ...
end
```

You may have to create a user.rb file containing a User model and extend it
from another engine's User model `app/models/user.rb`. For instance,

```ruby
require File.expand_path("../../app/models/user",
                         AnotherEngine::Engine.called_from)

# Extend User model.
class User
  include ThinkFeelDoDashboard::Concerns::Password
end
```

Copy the migrations from the ThinkFeelDoDashboard engine:

```console
rake think_feel_do_dashboard:install:migrations
```

Then run the migrations:
```console
bin/rake db:migrate
```

You will have to include any .css or .js files in the host app's to be precompiled `app/config/initializers/assets.rb`.  For example,
```
...
Rails.application.config.assets.precompile += %w(think_feel_do_dashboard.css think_feel_do_dashboard.js)
...
```
Be sure to restart your server after you mkae the modifications.

## Dependencies

ruby: 2.1.2

rails: ~> 4.1.7

## Configuration

__Application Name:__ ThinkFeelDoDashboard

__Github Repo:__ https://github.com/cbitstech/think_feel_do_dashboard

__Production Url:__ N/A

__Staging Url:__ N/A

__Confluence:__ N/A

## Database initialization/creation

Make sure you are in the top level folder; i.e., think_feel_do_dashboard. Then run:

```console
rake app:db:drop app:db:create app:db:migrate
```

## Seeding Database

```console
app:seed:with_fixtures
```

## Running tests

After you migrate the database, you may have to update the engine's testing environment:

```console
rake app:db:test:prepare
```

Because we have combined brakeman, rubocop, and rspec, you can just run the rake command to run everything:

```console
rake
```

## Services

N/A

## Deployment Instructions

See the "Installation" instructions above.

## To Do:

N/A