# frozen_string_literal: true

class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to post_path(@post)
    else
      flash[:info] = 'There was an issue saving your post.'
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = 'Post successfully edited'
      redirect_to @post
    else
      render :edit
    end
  end

  def index
    @posts = (current_user.friends.map(&:posts) + current_user.posts).flatten
    @posts = Post.all.take(10) if @posts[0].nil?
    @comment = Comment.new # To render comment form on post show view
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new # To render comment form on post show view
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
