# Bristle RB

Bristle is a personal career portfolio builder. This is the Rails API.

## Prerequisites

Ensure that you have the following technologies installed on your machine and that you are familiar with them.

* [Git](https://git-scm.com/)
* [Ruby 2.6.8](https://www.ruby-lang.org/en/news/2021/07/07/ruby-2-6-8-released/)
* [Ruby on Rails 6.1.3](https://weblog.rubyonrails.org/2021/2/17/Rails-6-1-3-has-been-released/)
* [PostgreSQL](https://www.postgresql.org/)
* [RSpec](https://github.com/rspec/rspec-rails)

## Installation

* `git clone git@github.com:danrice92/bristle-rb.git`
* `rbenv install 2.6.8`
* `gem install bundler`
* I recommend using the [Postgres app](https://postgresapp.com/), rather than Homebrew, for installing Postgres. Add this to your PATH: `export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"`. This will make the `pg` gem install correctly.
* `bundle`
* `bin/rails db:setup`

## Start the server

* `bin/rails s`

## Start the console

* `bin/rails c`

## Run tests

* `bin/rspec spec`
