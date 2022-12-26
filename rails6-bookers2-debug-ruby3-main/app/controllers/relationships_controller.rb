class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    relationship = Relationship.new
    relationship.follower_id = current_user.id
    relationship.followed_id = user.id
    relationship.save
    redirect_to request.referer
  end
  def destroy
    user = User.find(params[:user_id])
    relationship = Relationship.find_by(follower_id: current_user.id, followed_id: user.id)
    relationship.destroy
    redirect_to request.referer
  end
  def follow
    user = User.find(params[:user_id])
    @users =  user.follower_user
  end
  def followed
    user = User.find(params[:user_id])
    @users =  user.followed_user
  end
end
