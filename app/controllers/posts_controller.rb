class PostsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render :show, status: :created
    else
      render json: { message: "400 Bad Request" }, status: :bad_request
    end
  end

  def edit
  end

  def update
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      render json: { message: "Cannot find post" }, status: :not_found
    else
      @post.update(post_params)
    end
  end

  def show
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      render json: { message: "Cannot find post" }, status: :not_found
    end
  end

  def destroy
    @post = Post.find_by_id(params[:id])

    if @post.nil?
      render json: { message: "Cannot find post" }, status: :not_found
    else
      if @post.destroy
        render json: { message: "Successfully deleted" }, status: :no_content
      else
        render json: { message: "Unsuccessfully deleted" }, status: :bad_request
      end
    end
  end

  private

  def set_post
    @post = current_user.posts.find_by_id(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :created_at)
  end

end
