class AddUserIdToWallpapers < ActiveRecord::Migration
  def change
    add_column :wallpapers, :user_id, :integer
  end
end
