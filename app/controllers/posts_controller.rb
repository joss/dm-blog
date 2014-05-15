class PostsController < ApplicationController
  def index
    @posts = Post.order(updated_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments.order(updated_at: :desc).reject(&:new_record?)
    @new_comment = @post.comments.build
    @new_comment.build_remote_post
  end
end
