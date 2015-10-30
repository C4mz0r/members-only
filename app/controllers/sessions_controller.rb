class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email])
    #byebug
    if user.authenticate(params[:session][:password])
      sign_in(user)
      #render :text => 'looks like we signed in'
      render 'index'
    else
      redirect_to :login
    end
  end
  
  def destroy
    sign_out
    redirect_to :login 
  end
  
end
