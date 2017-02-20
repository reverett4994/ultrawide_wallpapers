class Wallpaper < ActiveRecord::Base
  has_attached_file :image,styles: {:thumb=> "100x100>"},processors: [:thumbnail, :paperclip_optimizer]
  validates_attachment_content_type :image, content_type: /\Aimage/
  belongs_to :user
  acts_as_votable
  acts_as_taggable # Alias for acts_as_taggable_on :tags
end
