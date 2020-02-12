class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  scope :ordered, -> { order(:tutorial_id, :position) }
end
