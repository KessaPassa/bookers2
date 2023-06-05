# frozen_string_literal: true

class Users::FollowersController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @users = user.followers.preload(:following, :followers).with_attached_profile_image
  end

  def create
    follower = User.find(params[:user_id])
    Relationship.create_or_destroy!(followed: current_user, follower:)

    redirect_to request.referer
  end
end
