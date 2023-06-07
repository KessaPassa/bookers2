# frozen_string_literal: true

class Group < ApplicationRecord
  has_one :owner, class_name: 'User', foreign_key: :id,
                  inverse_of: :groups, dependent: :destroy

  has_one_attached :image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

  def attached_image
    image.attached? ? image : 'no_image.jpg'
  end
end
