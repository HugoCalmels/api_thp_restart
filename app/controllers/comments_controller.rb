class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  before_action :creator?, only: [:update, :destroy]

  # GET /articles
  def index
    @comments = Comment.all.where(status: false)

    render json: @comments
  end

  # GET /articles/1
  def show
    if @comment.status == false || @comment.user == current_user
      render json: @comment
    else
      render json: @comment.errors ,status: :forbidden
    end
  end

  # POST /articles
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.article = Article.find(params[:article_id])

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:message)
    end

    def creator?
      @comment = Comment.find(params[:id])
      unless @comment.user == current_user
        render json: @comment.errors, status: :unauthorized
      end
    end
end