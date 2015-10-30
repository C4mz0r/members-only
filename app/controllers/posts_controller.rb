class PostsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]
  

  
  def new
    @post = Post.new
  end
  
  def create
    # needs error handling! 
    current_user.posts.create(post_params)
    #render :text => 'hey'
    redirect_to :posts
  end
  
  def index
    @posts = Post.all
  end
  
  
  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
    
    def signed_in_user
      redirect_to('/login') unless signed_in?
    end
  
end
