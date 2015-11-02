class PostsController < ApplicationController
  before_action :signed_in_user, only: [:new, :create]
  

  
  def new
    @post = Post.new
  end
  
  def create
    # needs error handling! 
    @post = current_user.posts.create(post_params)
    if @post.valid?
      redirect_to :posts  
    else
      flash.now[:error] = "Error in post"
      render 'posts/new'      
    end
    
  end
  
  def index
    #@posts = Post.all --> Notice a lot of noise querying for each user who wrote each post after the fact
    @posts = Post.includes(:user).all # use this to reduce the N+1 query problem
  end
  
  
  private
    def post_params
      params.require(:post).permit(:title, :body)
    end
    
    def signed_in_user
      redirect_to('/login') unless signed_in?
    end
  
end
