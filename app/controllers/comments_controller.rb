class CommentsController < ApplicationController

before_filter :authorize_user, :only => [:edit, :update, :destroy]
# only allow a user to comment on a post of someone they follow or their own
before_filter :authorize_comment_on_post, :only => [:create]

  def authorize_user
    @comment = Comment.find(params[:id])
    @user = User.find_by_id(@comment.user_id)
    if @user.id != session[:user_id]
      redirect_to root_url
    end
  end

  def authorize_comment_on_post
    post_owner_id = Post.find_by_id(params[:comment][:post_id]).user_id
    user_follows = Follow.where(:follower_id => session[:user_id], :followee_id => post_owner_id).exists?
    unless user_follows or post_owner_id == session[:user_id]
      redirect_to root_url
    end
  end

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new/1
  # GET /comments/new/1.json
  def new
    @comment = Comment.new
    @post_id = params[:post_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new
    @comment.body = params[:comment][:body]
    @comment.post_id = params[:comment][:post_id]
    @comment.user_id = session[:user_id]

    respond_to do |format|
      if @comment.save
        format.js
        format.html { redirect_to Post.find_by_id(@comment.post_id), notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to Post.find_by_id(@comment.post_id), notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
