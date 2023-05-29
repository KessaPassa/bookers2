# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :books, optional: true
  has_one_attached :profile_image

  # rubocop:todo Rails/UniqueValidationWithoutIndex
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # rubocop:enable Rails/UniqueValidationWithoutIndex

  def get_profile_image # rubocop:todo Naming/AccessorMethodName
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end
end
