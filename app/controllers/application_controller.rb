class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
  def sign_in(user)
    remember_token = SecureRandom.urlsafe_base64
    cookies.permanent[:remember_token] = remember_token
    self.current_user = user
    #byebug
  end
  
  def current_user
    @current_user ||= User.find_by(remember_token: Digest::SHA1.hexdigest(cookies[:remember_token])) 
    #byebug
    return @current_user
  end
  
  def current_user=(user)
    #byebug
    rt = Digest::SHA1.hexdigest(cookies[:remember_token])
    puts "Want to update the rt with #{rt}"#.colorize(:red)
    user.update_attribute(:remember_token, rt)
  end
  
  def sign_out
    #byebug
    current_user.remember_token = nil unless current_user.nil?
    cookies[:remember_token] = nil
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def display_name(user)
    signed_in? ? user.email : "Anonymous"
  end
  
  helper_method :display_name #so that view can see it
  helper_method :signed_in?
  
end
