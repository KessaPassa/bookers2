# frozen_string_literal: true

class DirectMessage < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :body, presence: true, length: { maximum: 140 }
end
