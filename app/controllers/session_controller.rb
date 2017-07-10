class SessionController < ApplicationController

  def new
  end

  def create

    user = User.find_by username: params[:username]

    if user.present? and user.authenticate(params[:password])

      session[:user_id] = user.id
      redirect_to root_path
      # set the cookie to the user id
      # redirect_to root_path # redirect to user profile
      # if user.is_admin
      #   redirect_to root_path
      # else
      #   redirect_to root_path
      # end
    else
      #mitmatch/bad credentials
      flash[:error] = "Incorrect email address and/or password"
      redirect_to login_path
    end


  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
