class CommentsController < ApplicationController
  before_action :find_commentable
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :check_if_logged_in, except: [:new]


  # GET /comments
  # GET /comments.json

  def check_score
    score = @comment.upvotes - @comment.downvotes
    # raise 'hell'
    @comment.update_attribute(:score, score)
  end

  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show

  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @commentable.comments.new comment_params
    @comment.user_id = @current_user.id
    if @comment.save
      redirect_to :back, notice: 'Your comment was successfully posted!'
    else
      redirect_to :back, notice: "Your comment wasn't posted!"
    end
  end


  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  #12 July 2017
    #By: Michelle
    #For upvoting
    def upvote
      @comment = Comment.find_by(id: params[:id])
      # raise 'hell'

      # the following line to be uncommented when we go live to allow for 1 vote per user
      # Vote.find_or_create_by(upvote: 1, post: @post, user: @current_user)
      Vote.create(upvote: 1, comment: @comment, user: @current_user)
      check_score()
      respond_to do |format|
      #   # if the response format is html, redirect as usual
        format.html { redirect_to root_path }
      #   # if the response format is javascript, do something else...
        format.js { }
      end
    end

    #11 July 2017
      #By: Michelle
      #For downvotes
    def downvote
      @comment = Comment.find_by(id: params[:id])
      # Vote.find_or_create_by(downvote: 1, post: @post, user: @current_user)
      Vote.create(downvote: 1, comment: @comment, user: @current_user)
      check_score()
      make_request()
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content)
      # params.require(:comment).permit(:content, :post_id, :user_id)
    end

    def find_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
    end
end
