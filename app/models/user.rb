class User < ActiveRecord::Base
  has_secure_password
  has_many :questions, dependent: :delete_all
  has_many :posts, dependent: :delete_all
  mount_uploader :avatar, AvatarUploader
  validate :avatar_size
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,	presence:	true,	length:	{	maximum:	255	}, format:	{	with:	VALID_EMAIL_REGEX	}, uniqueness:	{	case_sensitive:	false	}
  validates :name, presence: true, format: {with: /\A[a-zA-Z0-9]+\Z/}

  def authenticate?(password)
    BCrypt::Password(:password_digest).is_password?(password_digest)
  end

  def admin?
    if admin
      true
    end
  end

  def notifications_count
    size = Notification.where(user_id: self.id, seen: nil).size
  end

  private

  # Validates the size of an uploaded picture.
  def avatar_size
    if avatar.size > 5.megabytes
      errors.add(:avatar, "should be less than 5MB")
    end
  end
end
