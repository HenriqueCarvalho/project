class CommentsController < ApplicationController
  before_action :find_post, only: [:create, :edit, :update, :destroy, :upvote, :downvote]
  before_action :find_comment, only: [:edit, :update, :destroy, :upvote, :downvote]

  def create
    if user_signed_in?
      @comment = @post.comments.create(params[:comment].permit(:comment))
      @comment.user_id = current_user.id
      @comment.save
      if @comment.save
        redirect_to post_path(@post)
      else
        render 'new'
      end
    else
      #redirect_to '/users/sign_in', notice: "You need to be singed in to comment."
      redirect_to post_path(@post), notice: "You need to be singed in to comment."
    end
  end

  def edit
    if is_current_user?
      #update
    else
      redirect_to post_path(@post)
    end
  end

  def update
    if @comment.update(params[:comment].permit(:comment))
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    if is_current_user?
      @comment.destroy
    end

    redirect_to post_path(@post)
  end

  def upvote
    if user_signed_in?
      @comment.upvote_by current_user
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post), notice: "You need to be singed in to like."
    end
  end

  def downvote
    if user_signed_in?
      @comment.downvote_by current_user
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post), notice: "You need to be singed in to deslike."
    end
  end

  private

  def is_current_user?
    @comment.user_id == current_user.id
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end
end
