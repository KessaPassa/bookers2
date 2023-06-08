# frozen_string_literal: true

class User::Group < ApplicationRecord
  belongs_to :user
  belongs_to :group
end
