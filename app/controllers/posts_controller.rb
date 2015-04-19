class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
    #future impletation to redirect to path if there isn't the post id
    #if @post.nil?
      #redirect_to root_path
    #end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else 
      render 'new'
    end
  end

  def edit
    if is_current_user?
      #update the post
    else
      redirect_to post_path(@post)
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    if is_current_user?
      @post.destroy
      redirect_to root_path
    else
      redirect_to post_path(@post)
    end
  end

  def upvote
    @post.upvote_by current_user
    redirect_to post_path(@post)
  end

  def downvote
    @post.downvote_by current_user
    redirect_to post_path(@post)
  end

  private

  def is_current_user?
    current_user.posts.include?(@post)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
