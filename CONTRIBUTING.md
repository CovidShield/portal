# Contributing

Thank you for considering contributing to COVID Shield!

We’d love to get your issues (if you find any bugs) and PRs (if you have any fixes)!

First, please review this document and the [Code of Conduct](CODE_OF_CONDUCT.md).

# Reporting security issues

COVID Shield takes security very seriously. In the interest of coordinated disclosure,
we request that any potential vulnerabilities be reported privately in accordance with
our [security policy](SECURITY.md).

## Contributing documentation and non-code changes

If you'd like to contribute a documentation or static file change, please
feel free to fork the project in Github and open a PR from that fork against
this repository.

## Contributing code

If you'd like to contribute code changes, the following steps will help you
setup a local development environment. If you're a Shopify employee, `dev up`
will install the above dependencies and `dev {console,test,etc.}` will work
as you'd expect.

Once you're happy with your changes, please fork the repository and push your
code to your fork, then open a PR against this repository.

## Developing Locally

### Prerequisites

The setup steps expect the following tools to be installed on the system:

* [Ruby](https://guides.rubyonrails.org/getting_started.html#installing-ruby)
* [MySQL](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/)
* [Node.js](https://guides.rubyonrails.org/getting_started.html#installing-node-js-and-yarn)
* [Rails](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails-installing-rails)
* [COVID Shield Diagnosis Server](https://github.com/CovidShield/server)

### Running

#### 1. Check out the repository

```bash
git clone git@github.com:CovidShield/portal.git
```

#### 2. Update database.yml file

Update the database.yml file with your MySQL configuration as required.

#### 3. Create and set up the database

Run the following commands to create and set up the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
bundle exec rake db:seed
```

#### 4. Start the Rails server

You can start the rails server using the command given below (replacing the KEY_CLAIM_HOST to match your running diagnosis server config).

```ruby
KEY_CLAIM_HOST=localhost:3000 bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000

The default username and password is `admin@covidshield.app` and `password`.