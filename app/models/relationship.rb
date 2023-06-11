# frozen_string_literal: true

class Relationship < ApplicationRecord
  belongs_to :followed, class_name: 'User' # フォローするをされたユーザ
  belongs_to :follower, class_name: 'User' # フォローするをしたユーザ

  class << self
    def create_or_destroy!(followed:, follower:)
      relationship = find_or_initialize_by(followed:, follower:)
      if relationship.new_record?
        relationship.save!
      else
        relationship.destroy!
      end
    end
  end
end
