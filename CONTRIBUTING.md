# Contributing Guidelines

Welcome, and thank you for considering contributing to COVID Shield!

We’d love to get your issues (if you find any bugs) and PRs (if you have any fixes)!

- [Code of Conduct](#code-of-conduct)
- [Reporting Security Issues](#reporting-security-issues)
- [Contributing](#contributing)
  - [Contributing Documentation](#contributing-documentation)
  - [Contributing Code](#contributing-code)
- [Running COVID Shield](#running-covid-shield)
  - [From Scratch](#from-scratch)

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

### Prerequisites

The setup steps expect the following tools to be installed on the system:

- [Ruby - 2.7.1](https://guides.rubyonrails.org/getting_started.html#installing-ruby)
- [MySQL - 5.7](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/)
- [Node.js - 12.17.0](https://guides.rubyonrails.org/getting_started.html#installing-node-js-and-yarn)
- [Yarn - 1.22.0](https://guides.rubyonrails.org/getting_started.html#installing-node-js-and-yarn)
- [Rails - 6.0.3](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails-installing-rails)
- [COVID Shield Diagnosis Server](https://github.com/CovidShield/backend)


### Running
#### 1. Clone the repository

```bash
git clone git@github.com:CovidShield/portal.git
```

#### 2. Setup local environment

There are several environment variables you can set to configure the application.

To configure these:
1. Copy `config/local_env.yml.sample` to `config/local_env.yml`
1. Open `config/local_env.yml` and edit the values as needed

The available variables you can configure are:
* `DATABASE_HOST` - The host the MySQL server is running on (defaults to `localhost`)
* `DATABASE_USER` - The user MySQL is configured with for acces (defaults to `root`)
* `DATABASE_PASSWORD` - The password for the MySQL user (defaults to blank)
* `KEY_CLAIM_HOST` - The host the COVID Shield server is running on
* `KEY_CLAIM_TOKEN` - The token the COVID Shield server is configured to use

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
