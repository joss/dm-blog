class PostsController < ApplicationController
  def index
    @posts = Post.order(updated_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments.includes(:remote_posts).order(updated_at: :desc).reject(&:new_record?)
    @new_comment = @post.comments.build
  end
end
