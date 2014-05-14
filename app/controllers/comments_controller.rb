class CommentsController < ApplicationController
  before_filter :find_post

  def create
    @comment = @post.comments.new(comment_params)

    json_response = if @comment.save
      @new_comment = @post.comments.new
      { new_comment_html: render_to_string(@comment) }
    else
      @new_comment = @comment
      {}
    end

    new_form_html = render_to_string(partial: 'comments/new', locals: { post: @post, new_comment: @new_comment })
    render json: json_response.merge(new_form_html: new_form_html)
  end

  def destroy
    @post.comments.find(params[:id]).destroy
    head :ok
  end

  private
    def find_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
