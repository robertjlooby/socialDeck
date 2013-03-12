class PostsController < ApplicationController

  #can only edit, update, and destroy your own posts
  before_filter :authorize_users_post, :only => [:edit, :update, :destroy]
  #can only create new posts if you are a signed in user
  before_filter :authorize_signed_in, :only => [:new, :create]

  def authorize_users_post
    @post = Post.find(params[:id])
    @user = User.find_by_id(@post.user_id)
    if @user.id != session[:user_id]
      redirect_to root_url
    end
  end

  def authorize_signed_in
    unless session[:user_id].present?
      redirect_to sign_in_url
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order("updated_at desc")
    if params[:search].present?
      @posts = @posts.where("body LIKE ?", "%#{params[:search]}%")
    end
    @posts = @posts.page(params[:page]).per(20)


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @current_user = User.find_by_id(session[:user_id])
    @comments = Comment.where(:post_id => params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new(:post_type => 0) # default type is text post

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.create(params[:post])
    @post.user_id = session[:user_id]

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to :back}
      format.json { head :no_content }
    end
  end
end
