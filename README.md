DataCollector
=============

Specifications
--------------

- [x] Limit data returned to the current user.
- [x] Combine all graphs in a single chart.
- [x] Allow filtering of chart data using various fields.

Installation
------------

- Clone the repo and install bundled gems

        git clone https://github.com/nikhgupta/data_collector ~/data_collector
        bundle install --without development test

- Set the following environment variables for configuring database access:

        DATABASE_HOST, DATABASE_USER, DATABASE_NAME, and DATABASE_PASS

- Set the following environment variables:

        export RAILS_ENV=production
        export SECRET_KEY_BASE=`bundle exec rake secret`

- Run the following commands to create database, and import the sample
  data (note that, this will drop the existing database):

        bundle exec rake db:drop db:create db:migrate
        bundle exec rake import

- Run the rails server using:

        bundle exec rails server -b "0.0.0.0" -d

  This will start the server on port 3000. You can now visit the
  application on your server on port 3000, and create new users or use
  an existing one by specifying the UUID present in the
  `./data/customers.csv` file. Please, change the password for these
  users, afterwards.

- If you need to send emails when user registers, etc., you should set
  an env. variable `DEVISE_EMAIL_FROM`, which holds the email address
  which will be used to send these emails.


Installing Ruby
---------------

- Install [`rbenv`][rbenv-install], and [`ruby-build`][ruby-build-install].
- On ubuntu, you may need to install `build-essential` and some other
  packages (specifically, libraries for `openssl`, `readline`, and `zlib`):

        apt-get install -y build-essential
        apt-get install -y libssl-dev libreadline-dev zlib1g-dev libpq-dev

- Install Ruby v2.2.3 using `rbenv`:

        rbenv install 2.2.3 && rbenv global 2.2.3

- Install Bundler:

        gem install bundler

- Install a suitable JS runtime:

        apt-get install nodejs

Running Specs
-------------

You can run the test suite by issuing the following command:

`COVERAGE=1 bundle exec rspec`

This will, also, create a `coverage/index.html`, which contains the
coverage report for the code.

  [rbenv-install]: https://github.com/sstephenson/rbenv#installation
  [ruby-build-install]: https://github.com/sstephenson/ruby-build#installation
