class User < ActiveRecord::Base
  before_create :create_user_token
  
  has_secure_password
  has_many :posts
  
  private
    def create_user_token
      remember_token = SecureRandom.urlsafe_base64
      self.remember_token = Digest::SHA1.hexdigest(remember_token)
      #remember_token = SecureRandom.urlsafe_base64
      #encrypted_token = Digest::SHA1.hexdigest(remember_token)
      #self.remember_token = encrypted_token 
    end
  
end
