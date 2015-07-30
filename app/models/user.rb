class User < ActiveRecord::Base
  has_secure_password
  has_many :questions, dependent: :delete_all
  has_many :posts, dependent: :delete_all
  mount_uploader :avatar, AvatarUploader
  validate :avatar_size

  def authenticate?(password)
    BCrypt::Password(:password_digest).is_password?(password_digest)
  end

  def admin?
    if admin
      true
    end
  end

  def notifications_count
    size = Notification.where(user_id: self.id, seen: false).size
  end

  private

  # Validates the size of an uploaded picture.
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end
end
