class User < ActiveRecord::Base
  has_secure_password

  def authenticate?(password)
    BCrypt::Password(:password_digest).is_password?(password_digest)
  end
end
