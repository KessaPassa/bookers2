# frozen_string_literal: true

class NoticeMailer < ApplicationMailer
  def group_notice(group_notice:, member:)
    @group_notice = group_notice
    owner = group_notice.group.owner
    options = { from: owner.email, subject: group_notice.title }
    mail(to: member.email, **options)
  end
end
