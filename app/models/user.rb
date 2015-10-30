class User < ActiveRecord::Base
  before_create :create_user_token
  before_save {self.email = email.downcase}
  
  validates :name, presence: true, length: {maximum:50}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:50}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
  has_many :posts
  
  private
    def create_user_token
      remember_token = SecureRandom.urlsafe_base64
      self.remember_token = Digest::SHA1.hexdigest(remember_token)
      #remember_token = SecureRandom.urlsafe_base64
      #encrypted_token = Digest::SHA1.hexdigest(remember_token)
      #self.remember_token = encrypted_token 
    end
  
    def self.digest(string)
          cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)

    end
  
end
