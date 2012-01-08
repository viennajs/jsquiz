# [@cypher](https://twitter.com/cypher)'s solution

## Requirements

You need Ruby 1.9 for this. I've developed this using 1.9.3, but later versions should work as well.

## Setup

Install bundler:

    gem install bundler # prefix with sudo if needed

Install dependencies:

    bundle install

Initialize [jasmine](http://pivotal.github.com/jasmine/):

    bundle exec jasmine init

Run Guard:

    bundle exec guard

Run the Jasmine server:

    bundle exec rake jasmine

Open [http://localhost:8888]() to see the tests running.
