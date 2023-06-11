# frozen_string_literal: true

class DirectMessagesController < ApplicationController
  def show
    @receiver = User.find(params[:id])
    return render 'not_mutual_relationship' unless current_user.mutual_follow?(@receiver)

    @direct_messages = DirectMessage.where(sender: current_user, receiver: @receiver)
    @direct_message =  DirectMessage.new
  end

  def create
    dm = DirectMessage.new(direct_message_params)
    dm.sender_id = current_user.id
    dm.save!

    redirect_to direct_message_path(dm.receiver_id)
  end

  private

  def direct_message_params
    params.require(:direct_message).permit(:receiver_id, :body)
  end
end
