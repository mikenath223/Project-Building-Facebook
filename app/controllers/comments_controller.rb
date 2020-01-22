# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_comment, except: %i[create]

  def create
    @comment = Comment.new(comment_params)
    post_id = comment_params['post_id']
    @comment.user_id = current_user.id
    @post = Post.find(post_id)
    if @comment.save
      user = User.find(Post.find(post_id).user_id)
      flash[:success] = "Your comment was added to #{user.nickname || user.email}'s post."
    else
      flash[:danger] = 'An error occurred while adding your comment. Try again.'
    end
    redirect_to @post
  end

  def edit; end

  def update
    if @comment.update(update_params)
      flash[:success] = 'Comment updated successfully.'
    else
      flash[:danger] = 'Error in comment creation.'
    end
    redirect_to post_path(@comment.post)
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def update_params
    params.require(:comment).permit(:content)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end
end
