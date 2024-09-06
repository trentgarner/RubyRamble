class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]

  def index
    @blog_posts = BlogPost.all
  end

  def show
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
  end

  def update
    if @blog_post.update(blog_post_params)
      flash[:notice] = "Blog post was successfully updated."
      redirect_to @blog_post
    else
      flash[:alert] = "There was an error updating the blog post."
      render :edit
    end
  end

  def destroy
    @blog_post.destroy
    flash[:notice] = "Blog post was successfully deleted."
    redirect_to blog_posts_path
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Blog post not found."
  end

end
