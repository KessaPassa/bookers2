# frozen_string_literal: true

class NoticeMailer < ApplicationMailer
  def group_notice(group_notice:)
    @group_notice = group_notice
    owner = group_notice.group.owner
    options = { from: owner.email, subject: group_notice.title }

    members = group_notice.group.members
    members.each do |member|
      mail(to: member.email, **options)
    end
  end
end
