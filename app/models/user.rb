# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, class_name: 'Book::Comment', dependent: :destroy

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true # rubocop:todo Rails/UniqueValidationWithoutIndex
  validates :introduction, length: { maximum: 50 }

  def correct_user?(current_user)
    self == current_user
  end

  def get_profile_image # rubocop:todo Naming/AccessorMethodName
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end
end
