class SessionsController < ApplicationController
  #can only add new services if you are a signed in user
  before_filter :authorize_signed_in, :only => [:add]

  def authorize_signed_in
    unless session[:user_id].present?
      redirect_to sign_in_url
    end
  end

  def new
  end
  
  def create
    user = User.find_by_username(params[:username])
    if user.present? && user.confirmed_user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user
        return
      end
    end
    
    redirect_to sign_in_url, notice: "Incorrect username/password."
  end
  
  def destroy
    reset_session
    redirect_to root_url
    return
  end

  def add
    @user = User.find_by_id(session[:user_id])
    if params[:provider] == "twitter"
      @user.twitter_oauth_token = request.env["omniauth.auth"][:credentials][:token]
      @user.twitter_oauth_token_secret = request.env["omniauth.auth"][:credentials][:secret]
      @user.twitter_username = request.env["omniauth.auth"][:info][:nickname]
      @user.twitter_id = request.env["omniauth.auth"][:uid]
      @user.save!
      @user.twitter
      redirect_to @user, :notice => "Now you have twitter"
    else
      redirect_to @user, :notice => "#{params[:provider]} verification failed"
    end
  end

end
