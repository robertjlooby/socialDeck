class FollowsController < ApplicationController

  # POST /follow/1
  # POST /follow/1.json
  def create
    @follow = Follow.new
    @follow.followee_id = params[:id]
    @follow.follower_id = session[:user_id]

    respond_to do |format|
      if @follow.save
        format.html { redirect_to :back, notice: "You are now following #{User.find_by_id(params[:id]).username}" }
        format.json { render json: @follow, status: :created, location: @follow }
      else
        format.html { redirect_to :back }
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follow/1
  # DELETE /follow/1.json
  def destroy
    @follow = Follow.where(:follower_id => session[:user_id], :followee_id => params[:id])
    @follow.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: "You are now longer following #{User.find_by_id(params[:id]).username}" }
      format.json { head :no_content }
    end
  end

end