class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
  end
  def show

  end
  def new
    @post = Post.new
  end
  def edit

  end
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Hell yeah, Shawn! Your article was successfully saved.'
    else
      redirect_to :back, alert: 'Oh no! I was unable to save your post.'
    end
  end
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Boom! Your article was successfully updated.'
    else
      render :edit
    end
  end
  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:title, :content)
    end
    def find_post
      @post = Post.friendly.find(params[:id])
    end
end
