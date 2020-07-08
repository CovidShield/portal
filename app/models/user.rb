class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: {case_sensitive: true}

  validate :at_least_one_admin?, on: :update

  scope :admin, -> { where(admin: true) }

  private

  def at_least_one_admin?
    errors.add(:admin, 'At least one admin user must exist.') if removes_last_admin
  end

  def removes_last_admin
    admin_changed? && User.admin.count == 1 && admin == false
  end
end
