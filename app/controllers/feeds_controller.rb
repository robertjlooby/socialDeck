class FeedsController < ApplicationController

	before_filter :authorize_user

	def authorize_user
		unless session[:user_id].present?
			redirect_to sign_in_url
		end
	end

  # GET /feeds
  # GET /feeds.json
  def index
    @user = User.find(session[:user_id])
    poster_ids = []
    @user.follows.each do |follow|
      poster_ids = poster_ids.push(follow[:followee_id])
    end
    @posts = Post.order("updated_at desc")
    @posts = @posts.where({:user_id => poster_ids})
    @posts = @posts.page(params[:page]).per(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
end