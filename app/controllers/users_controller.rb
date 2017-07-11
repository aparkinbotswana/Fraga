class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :destroy]
  before_action :check_if_logged_in
  before_action :check_if_admin, only: [:index]

  def get_user
  @user = User.find params["id"]
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show

    @posts = Post.where user_id: @current_user

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
  @user = User.create user_params #julian changed

  if @user.id.present?
    session[:user_id] = @user.id # log in using when making a new account
    redirect_to root_path   # /users/17
  else
    render :new
  end
end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # def upvote(post)
  #   votes.create(upvote: 1, post: post)
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :latitude, :longitude, :image)
    end
end
