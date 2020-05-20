# COVID Shield Web Portal

![Master Docker build, tag, and push to Amazon ECR](https://github.com/CovidShield/portal/workflows/Master%20Docker%20build,%20tag,%20and%20push%20to%20Amazon%20ECR/badge.svg)

This web-based results portal is accessible only by healthcare professionals and can be deployed federally, provincially, or municipally. It provides unique temporary codes to healthcare professionals who then give those codes to users of the mobile app. This code gives the app access to upload their anonymized device identifiers. There is no association between these temporary codes and specific tests or individuals. The code is delivered over the phone so it cannot be traced to any individual or their test results.

For more information on how this all works, read through the [COVID Shield Rationale](https://github.com/CovidShield/rationale).

## Role (optional)

The use of this portal is optional and you can easily integrate the code creation system into any existing system that your public health officials have access to. After you have deployed the backend, you can generate keys with [simple API calls](https://github.com/CovidShield/backend/tree/master/examples/new-key-claim).

## Local development

### Prerequisites

The setup steps expect the following tools to be installed on the system:

- [Ruby](https://guides.rubyonrails.org/getting_started.html#installing-ruby)
- [MySQL](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/)
- [Node.js](https://guides.rubyonrails.org/getting_started.html#installing-node-js-and-yarn)
- [Rails](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails-installing-rails)
- [COVID Shield Diagnosis Server](https://github.com/CovidShield/backend)

### 1. Check out the repository

```bash
git clone git@github.com:CovidShield/portal.git
```

### 2. Update database.yml file

Update the database.yml file with your MySQL configuration as required.

### 3. Create and set up the database

Run the following commands to create and set up the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
bundle exec rake db:seed
```

### 4. Start the Rails server

You can start the rails server using the command given below (replacing the KEY_CLAIM_HOST to match your running diagnosis server config).

```ruby
KEY_CLAIM_HOST=localhost:3000 bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000

The default username and password is `admin@covidshield.app` and `password`.

## Who built COVID Shield?

We are a group of Shopify volunteers who want to help to slow the spread of COVID-19 by offering our
skills and experience developing scalable, easy to use applications. We are releasing COVID Shield
free of charge and with a flexible open-source license.

For questions, we can be reached at <press@covidshield.app>.
