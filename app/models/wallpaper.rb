class Wallpaper < ActiveRecord::Base
  has_attached_file :image
  validates_attachment_content_type :image, content_type: [/\Aimage\/.*\z/,/\Avideo\/.*\z/]
  belongs_to :user
  acts_as_votable
  acts_as_taggable # Alias for acts_as_taggable_on :tags
end
