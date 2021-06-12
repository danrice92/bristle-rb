# Bristle RB

Bristle is a personal career portfolio builder. This is the Rails API.

## Prerequisites

Ensure that you have the following technologies installed on your machine and that you are familiar with them.

* [Git](https://git-scm.com/)
* [Ruby 3.0.1](https://www.ruby-lang.org/en/news/2021/04/05/ruby-3-0-1-released/)
* [Ruby on Rails 6.1.3](https://weblog.rubyonrails.org/2021/2/17/Rails-6-1-3-has-been-released/)
* [PostgreSQL](https://www.postgresql.org/)
* [RSpec](https://github.com/rspec/rspec-rails)

## Installation

* `git clone git@github.com:danrice92/bristle-rb.git`
* `rbenv install 3.0.1`
* `gem install bundler`
* `bundle`
* `bin/rails db:setup`

## Installation - Apple Silicon

* Follow [this blog's steps](https://soffes.blog/homebrew-on-apple-silicon) to install Intel and Apple versions of Homebrew and use the "ibrew" alias below. OpenSSL must be installed using ibrew.
* `RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(ibrew --prefix openssl)" arch -x86_64 rbenv install 3.0.1` - Install Ruby 3.0.1 using the ibrew alias.

## Start the server

* `bin/rails s`

## Start the console

* `bin/rails c`

## Run tests

* `bin/rspec spec`
