class PostsController < ApplicationController

	before_action :authenticate_user! 
	before_action :set_post, only: [:show, :edit, :update, :destroy]
	before_action :owned_post, only: [:edit, :update, :destroy]
	def index
		#Let’s call our instance variable @posts. All we then want to do is capture all of the posts in the Post model!
		@posts = Post.all
	end
	def show  
  		#@post = Post.find(params[:id])

	end  

	def new
	    @post = current_user.posts.build
	  end

	  def create
	    @post = current_user.posts.build(post_params)

	    if @post.save
	      flash[:success] = "Your post has been created!"
	      redirect_to posts_path
	    else
	      flash[:alert] = "Your new post couldn't be created!  Please check the form."
	      render :new
	    end
	  end  
	def edit  
		#@post = Post.find(params[:id])
	end

	def update  
		if @post.update(post_params)
		  flash[:success] = "Post updated."	
		  #@post.update(post_params)
		  redirect_to posts_path
	  else
	  	flash.now[:alert] = "Update failed.  Please check the form."
		render :edit
	  end
	end  
	def destroy
		#@post = Post.find(params[:id])
		if @post.destroy
			flash[:notice] = "Your posted image was destroyed and will never be accessible again"  
			redirect_to root_path
		else
			flash.now[:alert] = "Destroy failed.  Check if the image exist or refresh the page and try again."
		end
	end

	private
	def post_params  
	  	params.require(:post).permit(:image, :caption)
	end  
	def set_post
		@post = Post.find(params[:id]) 
	end
	def owned_post  
  unless current_user == @post.user
    flash[:alert] = "Nice play ! but that post dosn't belong to you."
    redirect_to root_path
  end
end  

end
