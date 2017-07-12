class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :fetch_user

  private
    def fetch_user
    #  session[:user_id] = nil
     @current_user = User.find_by id: session[:user_id] if session[:user_id].present?
     session[:user_id] = nil unless @current_user.present?
    end

  def check_if_logged_in
    redirect_to login_path unless @current_user.present?
  end

  def check_if_admin
    redirect_to root_path unless @current_user.present? && @current_user.is_admin
  end
  # Michelle - for up/down votes

  def make_request
    respond_to do |format|
    #   # if the response format is html, redirect as usual
      format.html { redirect_to root_path }
    #   # if the response format is javascript, do something else...
      format.js { }
    end

  end

end
