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
        if User.exists?(:twitter_id => tweet[:user][:id])
          p.user_id = User.find_by_twitter_id(tweet[:user][:id]).id
        else
          p.user_id = -1
        end
        p.post_type = 3
        p.created_at = tweet[:created_at].to_datetime
        url = "https://api.twitter.com/1/statuses/oembed.json?id=#{tweet[:id]}&omit_script=true"
        begin
          tweet_page = open(URI.parse(url))
          p.body = JSON.parse(tweet_page.read)['html']
          if p.save!
            @posts.push(p)
          end
        rescue
          # Tried to access a protected tweet, just skip it
        end
      end
    end

    @body_class = 'twitter-background'
    respond_to do |format|
      format.html # twitter.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /feeds/facebook
  # GET /feeds/facebook.json
  def facebook
    @user = User.find(session[:user_id])
    f = @user.facebook
    unless f.present?
      redirect_to @user, :notice => "Please add your facebook account!"
      return
    end
    @feed = f.feed
    @posts = []
    @feed.each do |post|
      if Post.exists?(:facebook_post_id => post.raw_attributes[:id])
        @posts.push(Post.find_by_facebook_post_id(post.raw_attributes[:id]))
      else
        p = Post.new
        p.poster_facebook_id, p.facebook_post_id = post.raw_attributes[:id].split("_")
        #p.poster_facebook_id = post.from.raw_attributes[:id]
        if User.exists?(:facebook_id => post.from.raw_attributes[:id])
          p.user_id = User.find_by_facebook_id(post.from.raw_attributes[:id]).id
        else
          p.user_id = -2
        end
        p.post_type = 4
        p.created_at = post.created_time.to_datetime
        #url = "http://noembed.com/embed?url=#{post.endpoint}?access_token=#{@user.facebook_oauth_token}"
        url = "#{post.endpoint}?access_token=#{@user.facebook_oauth_token}"
        #p.body = JSON.parse(open(URI.parse(url)).read)['html']
        puts url
        #puts JSON.parse(open(URI.parse(url)).read)
        if p.save!
          @posts.push(p)
        end
      end
    end

    @body_class = 'facebook-background'
    respond_to do |format|
      format.html # facebook.html.erb
      format.json { render json: @posts }
    end
  end
end