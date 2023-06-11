# frozen_string_literal: true

class User::Group < ApplicationRecord
  belongs_to :user
  belongs_to :group, class_name: '::Group'

  class << self
    def create_or_destroy!(group:, user:)
      return if group.owner?(user)

      group_user = find_or_initialize_by(group:, user:)
      if group_user.new_record?
        group_user.save!
      else
        group_user.destroy!
      end
    end
  end
end
