class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
  scope :non_classroom, -> {where classroom: false}

  def has_videos?
    videos.any?
  end
end
