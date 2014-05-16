require 'open-uri'

class CommentsController < ApplicationController
  before_filter :find_post, only: [:create, :destroy]

  def create
    @comment = @post.comments.new(comment_params)

    json_response = if @comment.save
      @new_comment = @post.comments.new
      @new_comment.build_remote_post
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

  def parse_remote_post
    #TODO: introduce to lib
    begin
      uri = URI.parse(params[:url])
      doc = Nokogiri::HTML(open(uri))

      url_base = uri.to_s.gsub(uri.path, '')

      images = doc.css('img').map do |el|
        image_path = el.attribute('src').try(:text).to_s
        delimeter = image_path.starts_with?('/') ? '' : '/'
        URI.parse(image_path).scheme ? image_path : [url_base, delimeter, image_path].join
      end

      remote_post = RemotePost.new(title: doc.title, h1: doc.css('h1').text, source: params[:url], logo_url: images.first)

      remote_post_preview_html = render_to_string(
        partial: 'comments/remote_post_preview',
        locals: { remote_post: remote_post, images: images }
      )

      render json: { remote_post_preview_html: remote_post_preview_html, remote_post: remote_post.attributes.slice(*%w(title h1 source logo_url)) }
    rescue Exception => e
      p e
      render json: { status: :error }
    end
  end

  private
    def find_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:body, remote_post_attributes: [:title, :source, :h1, :logo_url])
    end
end
