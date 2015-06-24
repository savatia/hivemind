class User < ActiveRecord::Base
  has_secure_password
  has_many :questions

  def authenticate?(password)
    BCrypt::Password(:password_digest).is_password?(password_digest)
  end

  def admin?
    if admin
      true
    end
  end
end
