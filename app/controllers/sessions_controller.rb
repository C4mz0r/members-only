class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email])    
    if user && user.authenticate(params[:session][:password])
      sign_in(user)      
      redirect_to posts_path
    else      
      render :controller => 'sessions', :action => 'new'      
    end
  end
  
  def destroy
    sign_out
    redirect_to :login 
  end
  
end
