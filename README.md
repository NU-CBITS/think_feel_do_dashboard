<h1>ThinkFeelDoDashboard</h1>

This is a rails engine that allows for the CRUDing and Enrolling of participants

Download <code>git clone https://github.com/cbitstech/?.git [name of folder]</code>

<h2>Assumptions</h2>

This engine expects there to be a Devise-like API available, and an authenticatable Participant class stored in a participants table.

<h2>Installation</h2>

Add to your Gemfile

<code>gem 'think_feel_do_dashboard', git: 'git://github.com/cbitstech/think_feel_do_dashboard.git'</code>

Then

<code>bundle install</code>

<h2>Dependencies</h2>

ruby: 2.1.2

rails: ~> 4.1.6

jQuery

<h2>Configuration</h2>

Application Name: ThinkFeelDoDashboard

Github Repo: https://github.com/cbitstech/?

Production Url:

Staging Url:

Confluence:

<h2>Database creation</h2>

<code>rake db:drop db:create db:migrate</code>

<h2>Database initialization</h2>

<h2>Running tests</h2>

<code>rake app:db:migrate</code>

<code>rspec</code>

<h2>Services (job queues, cache servers, search engines, etc.)</h2>

<h2>Deployment Instructions</h2>

<ul>
  <li></li>
</ul>

<h3>Production</h3>

<h3>Staging</h3>

<h2>Possible future 'To Dos'</h2>