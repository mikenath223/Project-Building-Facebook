class CommentsController < ApplicationController  
  def create
    @comment = Comment.new(comment_params)
    post_id = comment_params["post_id"]
    @comment.user_id = current_user.id
    @post = Post.find(post_id)
    if @comment.save
      user = User.find(Post.find(post_id).user_id)
      flash[:success] = "Your comment was added to #{user.nickname}'s post."
      redirect_to @post
    else
      flash[:danger] = "An error occurred while adding your comment. Try again."
      redirect_to @post
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = "Comment updated successfully."
      redirect_to 
    else
      flash[:danger] = "Error in comment creation."
      redirect_to path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
