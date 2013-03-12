class UsersController < ApplicationController

  before_filter :authorize_user, :only => [:edit, :update, :destroy]

  def authorize_user
    @user = User.find(params[:id])
    if @user.id != session[:user_id]
      redirect_to root_url
    end
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.order("username desc")
    if params[:search].present?
      @users = @users.where("email LIKE ? OR name LIKE ? OR username LIKE ?", 
        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end
    @users = @users.page(params[:page]).per(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @current_user = User.find(session[:user_id])
    @posts = Post.where(:user_id => @user.id).order("updated_at desc")
    @posts = @posts.page(params[:page]).per(20)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.confirmed_user = false

    respond_to do |format|
      if @user.save
        @user.send_account_activation
        format.html { redirect_to root_url, notice: "Email sent with account confirmation instructions." }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # GET /users/new/:token
  # GET /users/new/:token.json
  def confirm
    @user = User.find_by_user_confirmation_token(params[:token])
    if @user.present?
      @user.confirmed_user = true
      session[:user_id] = @user.id
      respond_to do |format|
        format.html { redirect_to @user, :notice => "Your account has been confirmed!"}
        format.json { head :no_content}
      end
    else
      respond_to do |format|
        format.html { redirect_to sign_in_url, :notice => "Account not found.  Please try resetting your password."}
        format.json { head :no_content}
      end
    end
  end
end
