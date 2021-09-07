class User < ApplicationRecord
  attr_accessor :activation_token

  before_save { self.email = email.downcase }

  has_many :articles, dependent: :destroy

  before_create {
    self.activation_token  = SecureRandom.urlsafe_base64  
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    self.activation_digest = BCrypt::Password.create(self.activation_token, cost: cost)
      }


  #before_create :create_activation_digest

  validates :username, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: { minimum: 3, maximum: 25 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, 
                      uniqueness: { case_sensitive: false }, 
                      length: { maximum: 105 },
                      format: { with: VALID_EMAIL_REGEX }

  has_secure_password 

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  
end