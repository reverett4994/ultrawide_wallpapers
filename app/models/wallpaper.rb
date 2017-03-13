class Wallpaper < ActiveRecord::Base
  has_attached_file :image,styles: {:thumb=> "1000x1000>"},:convert_options => {
                                                            :thumb => "-quality 80 -interlace Plane"
                                                          }
  validates :title, uniqueness: true
  validates_attachment_content_type :image, content_type: /\Aimage/
  belongs_to :user
  acts_as_votable
  acts_as_taggable # Alias for acts_as_taggable_on :tags

  def to_param
    "#{title}"
  end
end
