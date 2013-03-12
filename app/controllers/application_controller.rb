class ApplicationController < ActionController::Base
  protect_from_forgery

  
  # GET /application
  # GET /application.json
  def index
  	if params[:search_type] == 'Posts'
	    redirect_to :controller => :posts, :action => :index, :search => params[:search]
	elsif params[:search_type] == 'Users'
	    redirect_to :controller => :users, :action => :index, :search => params[:search], :search_type => 'Email'
	end
  end
end
