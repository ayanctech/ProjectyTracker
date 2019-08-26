class User < ApplicationRecord
  before_create :confirmation_token

  has_many :notifications

  has_secure_password
  validates :password, length: { minimum: 6 }

  has_many :projects, dependent: :destroy


  validates :name,presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[0-9a-zA-Z\.]+\@[a-zA-Z]+\.[a-zA-Z]+\z/}
  before_save :sanitize_name

  scope :sorted, -> { order("name ASC") }
  scope :search, ->(query) { where("name LIKE ? OR email LIKE?", "%#{query}%".titleize, "%#{query}%")}

  def email_activate
    self.email_confirmed = true
    self.confirm_token= nil
    save!(validate: false)
  end


  def self.find_or_create_from_auth_hash(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.name = auth.extra.raw_info.displayName
			user.email = auth.extra.raw_info.userPrincipalName
      user.password=auth.uid
			user.save!
		end
	end

  private
  def sanitize_name
    self.name=self.name.titleize
  end


  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token=SecureRandom.urlsafe_base64.to_s
    end
  end

end
