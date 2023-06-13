# frozen_string_literal: true

class Groups::NoticesController < ApplicationController
  def new
    @group_notice = Group::Notice.new
  end

  def create
    group = Group.find(params[:group_id])
    group_notice = Group::Notice.new(group_notice_params)
    group_notice.group = group
    group_notice.save!
    NoticeMailer.group_notice(group_notice:).deliver_later

    render 'send_complete'
  end

  private

  def group_notice_params
    params.require(:group_notice).permit(:title, :body)
  end
end
