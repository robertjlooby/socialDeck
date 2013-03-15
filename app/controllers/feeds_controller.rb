class FeedsController < ApplicationController
  require 'open-uri'

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

  # GET /feeds/twitter
  # GET /feeds/twitter.json
  def twitter
    @user = User.find(session[:user_id])
    t = @user.twitter
    unless t.present?
      redirect_to @user, :notice => "Please add your twitter account!"
      return
    end
    @tweets = t.home_timeline
    @posts = []
    @tweets.each do |tweet|
      if Post.exists?(:tweet_id => tweet[:id])
        @posts.push(Post.find_by_tweet_id(tweet[:id]))
      else
        p = Post.new
        p.tweet_id = tweet[:id]
        p.tweeter_twitter_id = tweet[:user][:id]
        if User.exists(:twitter_id => tweet[:user][:id])
          p.user_id = User.find_by_twitter_id(tweet[:user][:id]).id
        else
          p.user_id = -1
        end
        p.post_type = 3
        p.created_at = tweet[:created_at].to_datetime
        url = "https://api.twitter.com/1/statuses/oembed.json?id=#{tweet[:id]}&omit_script=true"
        p.body = JSON.parse(open(URI.parse(url)).read)['html']
        p.save!
        @posts.push(p)
      end
    end

    @body_class = 'twitter-background'
    respond_to do |format|
      format.html # twitter.html.erb
      format.json { render json: @posts }
    end
  end
end