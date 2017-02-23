class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 has_attached_file :temp_pic
 validates_attachment_content_type :temp_pic, content_type: /\Aimage/

  has_many :wallpapers
  acts_as_voter
end
