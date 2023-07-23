class User < ApplicationRecord
  attr_accessor :google_signup

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }

  with_options unless: :google_signup? do |user|
    user.validates :username, presence: true, uniqueness: true, length: { maximum: 30 }
    user.validates :phone_number, presence: true, uniqueness: true, length: { maximum: 100 }
  end

  def google_signup?
    google_signup.present?
  end

  has_secure_password
  before_save { email.downcase! }

  default_scope {order('users.created_at ASC')}

  Roles = [:super_admin , :admin, :customer]

  def is?( requested_role )
    self.role == requested_role.to_s
  end
end
