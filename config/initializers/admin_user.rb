# TODO This shouldn't be in here, but it makes for a more pleasant onboarding experience.

if ENV["ADMIN_PASSWORD"].present? && Rails.env.production?
  User.where(username: 'admin@covidshield.app').first_or_initialize.tap do |user|
    user.password = ENV["ADMIN_PASSWORD"]
    user.admin = true
    user.save
  end
end
