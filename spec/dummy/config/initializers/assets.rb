# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w(think_feel_do_engine.css think_feel_do_dashboard.css jquery.js think_feel_do_dashboard.js think_feel_do_engine/devise/passwords/edit.js think_feel_do_engine/users.js)