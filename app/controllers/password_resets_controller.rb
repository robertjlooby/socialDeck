class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	user.send_password_reset if user
  	redirect_to root_url, :notice => "Email send with password reset instructions."
  end

  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	if @user.password_reset_sent_at < 1.hour.ago
  		redirect_to new_password_reset_path, :notice => "Password reset has expired."
  	elsif @user.update_attributes(params[:user])
      session[:user_id] = @user.id
  		redirect_to @user, :notice => "Password has been reset."
  	else
  		render :edit
  	end
  end
end
