class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :full_name, presence: true
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :phone_number, presence: true, uniqueness: true, length: { maximum: 100 }

  has_secure_password
  before_save { email.downcase! }

  default_scope {order('users.created_at ASC')}

  Roles = [:super_admin , :admin, :customer]

  def is?( requested_role )
    self.role == requested_role.to_s
  end
end
