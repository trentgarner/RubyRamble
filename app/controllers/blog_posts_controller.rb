class BlogPostsController < ApplicationController

  def index
    @blog_posts = BlogPost.all
  end

  def show
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Blog post not found."
  end
  
  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.save
      flash[:notice] = "Blog post was successfully created."
      redirect_to @blog_post
    else
      flash[:alert] = "There was an error saving the blog post."
      render :new
    end
  end

  def edit
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Blog post not found."
  end

  def update
    @blog_post = BlogPost.find(params[:id])
    if @blog_post.update(blog_post_params)
      flash[:notice] = "Blog post was successfully updated."
      redirect_to @blog_post
    else
      flash[:alert] = "There was an error updating the blog post."
      render :edit
    end
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end
end
