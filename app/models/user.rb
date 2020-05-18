class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: {case_sensitive: true}
end
