# ThinkFeelDoDashboard

[![Build Status](https://travis-ci.org/cbitstech/think_feel_do_dashboard.svg)](https://travis-ci.org/cbitstech/think_feel_do_dashboard) [![security](https://hakiri.io/github/cbitstech/think_feel_do_dashboard/master.svg)](https://hakiri.io/github/cbitstech/think_feel_do_dashboard/master)

This is a rails engine that allows for the CRUDing and Enrolling of participants

## Mockups

[Membership & Enrollment Mockups](https://moqups.com/#!/edit/michael.wehrley@gmail.com/bfbZNvUJ)

### Download
```
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

Add to your Gemfile

```
gem 'think_feel_do_dashboard', git: 'git://github.com/cbitstech/think_feel_do_dashboard.git'
```

Then

```
bundle install
```

### Links:

1. projects: `/think_feel_do_dashboard/projects`
2. arms: `/think_feel_do_dashboard/arms`
3. groups: `/think_feel_do_dashboard/groups`
4. participants: `/think_feel_do_dashboard/participants`
5. memberships: `/think_feel_do_dashboard/participants/1/groups`
6. coach_assignments: `/think_feel_do_dashboard/participants/1/coaches`

## Dependencies

ruby: 2.1.2

rails: ~> 4.1.6

## Configuration

__Application Name:__ ThinkFeelDoDashboard

__Github Repo:__ https://github.com/cbitstech/think_feel_do_dashboard

__Production Url:__ N/A

__Staging Url:__ N/A

__Confluence:__ N/A

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

N/A

## Deployment Instructions

N/A