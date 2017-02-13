class AddAttachmentImageToWallpapers < ActiveRecord::Migration
  def self.up
    change_table :wallpapers do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :wallpapers, :image
  end
end
