# TODO This shouldn't be in here, but it makes for a more pleasant onboarding experience.

if Rails.application.credentials.admin_password && Rails.env.production?
  User.where(username: 'admin@covidshield.app').first_or_initialize.tap do |user|
    user.password = Rails.application.credentials.admin_password
    user.admin = true
    user.save
  end
end
