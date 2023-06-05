# frozen_string_literal: true

class Users::FollowingController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @users = user.following.preload(:following, :followers).with_attached_profile_image
  end

  def create
    followed = User.find(params[:user_id])
    Relationship.create_or_destroy!(followed:, follower: current_user)

    redirect_to request.referer
  end
end
