# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, class_name: 'Book::Comment', dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: :follower_id,
                                  inverse_of: :followed, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :followed_id,
                                   inverse_of: :follower, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :group_users, class_name: 'User::Group', dependent: :destroy
  has_many :groups, through: :group_users
  has_many :senders, class_name: 'DirectMessage', foreign_key: :sender_id,
                     inverse_of: :sender, dependent: :destroy
  has_many :receivers, class_name: 'DirectMessage', foreign_key: :receiver_id,
                       inverse_of: :receiver, dependent: :destroy

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true # rubocop:todo Rails/UniqueValidationWithoutIndex
  validates :introduction, length: { maximum: 50 }

  scope :search, lambda { |word, matching_kind|
    case matching_kind
    when '0'
      model.where(name: word)
    when '1'
      model.where('name LIKE ?', "%#{word}")
    when '2'
      model.where('name LIKE ?', "#{word}%")
    when '3'
      model.where('name LIKE ?', "%#{word}%")
    else
      none
    end
  }

  def correct_user?(current_user)
    self == current_user
  end

  def mutual_follow?(user)
    mutual_follow_users.include?(user)
  end

  def get_profile_image # rubocop:todo Naming/AccessorMethodName
    profile_image.attached? ? profile_image : 'no_image.jpg'
  end

  private

  def mutual_follow_users
    Relationship
      .includes(:followed)
      .where(follower: self)
      .where(followed: followers)
      .map(&:followed)
  end
end
