# COVID Shield Web Portal

![Master Docker build, tag, and push to Amazon ECR](https://github.com/CovidShield/portal/workflows/Master%20Docker%20build,%20tag,%20and%20push%20to%20Amazon%20ECR/badge.svg)

This web-based results portal is accessible only by healthcare professionals and can be deployed federally, provincially, or municipally. It provides unique temporary codes to healthcare professionals who then give those codes to users of the mobile app. This code gives the app access to upload their anonymized device identifiers. There is no association between these temporary codes and specific tests or individuals. The code is delivered over the phone so it cannot be traced to any individual or their test results.

For more information on how this all works, read through the [COVID Shield Rationale](https://github.com/CovidShield/rationale).

## Role (optional)

The use of this portal is optional and you can easily integrate the code creation system into any existing system that your public health officials have access to. After you have deployed the backend, you can generate keys with [simple API calls](https://github.com/CovidShield/backend/tree/master/examples/new-key-claim).

## User Experience

- [Design files on Figma](https://www.figma.com/file/b76OYDhkTKJCaqDfVQybQY/Open-Source-COVID-Shield?node-id=68%3A167)
- [Glossary of terms](https://github.com/CovidShield/rationale/blob/master/GLOSSARY.md)

## Local development

### Prerequisites

The setup steps expect the following tools to be installed on the system:

- [Ruby](https://guides.rubyonrails.org/getting_started.html#installing-ruby)
- [Rails](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails-installing-rails)
- [MySQL](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/)
- [Node.js](https://guides.rubyonrails.org/getting_started.html#installing-node-js-and-yarn)
- [Webpack](https://github.com/webpack/webpack#install)
- [Yarn](https://yarnpkg.com/getting-started/install#global-install)
- [COVID Shield Diagnosis Server](https://github.com/CovidShield/server)
- [Docker/Docker Compose](https://docs.docker.com/get-started/#set-up-your-docker-environment)

### Check out the repository

```bash
git clone git@github.com:CovidShield/portal.git
```

### Install dependencies

```bash
# If you don't have the bundler gem, do this next line too:
# gem install bundler

bundle install
```

On MacOS, you may get issues installing the `mysql2` Gem. If you have [Homebrew](https://brew.sh/), you can install it this way:

```bash
brew install mysql openssl
gem install mysql2 -- --with-cflags=\"-I/usr/local/opt/openssl@1.1/include\" --with-ldflags=\"-L/usr/local/opt/openssl@1.1/lib\"
bundle install
```
### (Optional) Create a new MySQL Database using Docker

If you don't already have a local MySQL database, you can create one easily.

First, create a directory for the local data storage:

```bash
mkdir mysql-data
```

Second, start the database using Docker:

```bash
docker run -it --rm -p 3306:3306 --name portal-db -v $PWD/mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=stayhealthy -d mysql
```

This will create a database with the following properties:

- IP: `127.0.0.1`
- Port: `3306`
- User: `root`
- Password: `stayhealthy`

To kill it later, use:

```
docker kill portal-db
```

### Update database.yml file

Update the [database.yml](config/database.yml) file with your MySQL configuration as required.

If you're using the Docker-based MySQL from the above section, your `default` section will look like this:

```yaml
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: root
  password: stayhealthy
  host: 127.0.0.1
```

### Create and set up the database

Run the following commands to create and set up the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
bundle exec rake db:seed
```

### Start the Webpack Server

Open a new terminal window, navigating into the base of the repo, and start the Webpack server:

`./bin/webpack -w`

### Start the Rails server

You can start the rails server using the command given below (replacing the KEY_CLAIM_HOST to match your running diagnosis server config).

```ruby
KEY_CLAIM_HOST=127.0.0.1:8000 bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000

The default username and password is `admin@covidshield.app` and `password`.

## Who built COVID Shield?

We are a group of Shopify volunteers who want to help to slow the spread of COVID-19 by offering our
skills and experience developing scalable, easy to use applications. We are releasing COVID Shield
free of charge and with a flexible open-source license.

For questions, we can be reached at <press@covidshield.app>.
