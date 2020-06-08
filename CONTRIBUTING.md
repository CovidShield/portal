# Contributing Guidelines

Welcome, and thank you for considering contributing to COVID Shield!

We’d love to get your issues (if you find any bugs) and PRs (if you have any fixes)!

- [Code of Conduct](#code-of-conduct)
- [Reporting Security Issues](#reporting-security-issues)
- [Contributing](#contributing)
  - [Contributing Documentation](#contributing-documentation)
  - [Contributing Code](#contributing-code)
- [Running the COVID Shield portal](#running-covid-shield)
  - [Prerequisites](#Prerequisites)
  - [Running](#running)
  - [Testing](#testing)

## Code of Conduct

First, please review this document and the [Code of Conduct](CODE_OF_CONDUCT.md).

## Reporting Security Issues

COVID Shield takes security very seriously. In the interest of coordinated disclosure,
we request that any potential vulnerabilities be reported privately in accordance with
our [security policy](SECURITY.md).

## Contributing

### Contributing Documentation

If you'd like to contribute a documentation or static file change, please
feel free to fork the project in Github and open a PR from that fork against this repository.

### Contributing Code

If you'd like to contribute code changes, the following steps will help you
setup a local development environment. If you're a Shopify employee, `dev up`
will install the above dependencies and `dev {console,test,etc.}` will work
as you'd expect.

If you're not at Shopify, please see below.

Once you're happy with your changes, please fork the repository and push your
code to your fork, then open a PR against this repository.

## Running the COVID Shield portal

### Deployment

#### Docker Container

The [covidshield/portal](https://hub.docker.com/r/covidshield/portal) container on dockerhub cannot be used as is. In order to deploy it successfully you either have to:

* Create your own container (the container on dockerhub can be used as a base layer) and replace the `config/credentials.yml.enc` file with your own.
* Use the dockerhub container, and use a volume mount when deploying to provide your own `credentials.yml.enc` file. In this case, be sure to set the `RAILS_CREDENTIALS_PATH` environment variable.

#### Environment Variables

* Required
  * `RAILS_MASTER_KEY` - The encryption key used to decrypt your encrypted credentials file (e.g. `config/credentials.yml.enc`).
  * `DATABASE_URL` - The string used to connect to the MySQL database (e.g. `mysql2://myuser:mypass@localhost/somedatabase`).
  * `RAILS_ENV` - The Rails environment to use. Should always be set to `production` (even in docker-compose).
* Optional
  * `RAILS_CREDENTIALS_PATH` - Overrides the default encrypted credentials path. Set this if you're providing your own file at the non-standard location (i.e. `config/credentials.yml.enc`).

### Prerequisites

The setup steps expect the following tools to be installed on the system:

#### 1. [Ruby - 2.7.1](https://guides.rubyonrails.org/getting_started.html#installing-ruby)

You can use [rbenv](https://github.com/rbenv/rbenv) or [rvm](https://github.com/rvm/rvm) to install the specific version you need.

Example using `rvm`:

```bash
rvm install 2.7.1
rvm use 2.7.1
```

#### 2. [MySQL - 5.7](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/)

You can use the official [MySQL installer](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/installing.html) or you can use [homebrew](https://brew.sh/).

Example using `homebrew`:

```bash
brew install mysql
brew services start mysql
```

#### 3. [Node.js - 12.17.0](https://guides.rubyonrails.org/getting_started.html#installing-node-js-and-yarn)

You can use the official [Node.js installer](https://nodejs.org/en/download/) or [nvm](https://github.com/nvm-sh/nvm).

Example using `nvm`:

```bash
nvm install 12.17.0
nvm use 12.17.0
```

#### 4. [Yarn - 1.22.0](https://guides.rubyonrails.org/getting_started.html#installing-node-js-and-yarn)

You can use the official installation script or [homebrew](https://brew.sh/).

Example using `homebrew`:

```bash
brew install yarn
```

#### 5. [Rails - 6.0.3.1](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails-installing-rails)

```bash
gem install rails -v 6.0.3.1
```

#### 6. [COVID Shield Diagnosis Server](https://github.com/CovidShield/backend)

You will need to follow the [instructions for setting up the Diagnosis Server](https://github.com/CovidShield/server/blob/master/CONTRIBUTING.md#running).

### Running

#### 1. Clone the repository

```bash
git clone git@github.com:CovidShield/portal.git
```

#### 2. Setup local environment

There are several environment variables you can set to configure the application.

To configure these:

1. `cp config/local_env.yml.sample config/local_env.yml`
1. Open `config/local_env.yml` and edit the values as needed

The available variables you can configure are:

- `DATABASE_HOST` - The host the MySQL server is running on (defaults to `localhost`)
- `DATABASE_USER` - The user MySQL is configured with for acces (defaults to `root`)
- `DATABASE_PASSWORD` - The password for the MySQL user (defaults to blank)
- `KEY_CLAIM_HOST` - The host the COVID Shield server is running on
- `KEY_CLAIM_TOKEN` - The token the COVID Shield server is configured to use

#### 3. Install dependencies

```bash
bundle install
yarn install
```

#### 4. Create and set up the database

Run the following commands to create and set up the development database.

```ruby
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
```

#### 5. Start the Rails server

You can start the rails server using the command given below replacing the `KEY_CLAIM_HOST` to match the URL of your running diagnosis server config and the `KEY_CLAIM_TOKEN` to match the token it is running with.

```ruby
bundle exec rails server
```

And now you can visit the portal with the URL http://localhost:3000

The default username and password is `admin@covidshield.app` and `password`.

### Testing

### Running the controller tests

```ruby
bundle exec rails test
```

### Running the system tests

```ruby
bundle exec rails test:system
```
