class AddColumnAvatarToUsers < ActiveRecord::Migration
  def change
		add_column :users, :pic_file_name, :string
		add_column :users, :pic_file_size, :integer
		add_column :users, :pic_content_type, :string
		add_column :users, :pic_updated_at, :datetime
		add_column :users, :pic_image_width, :integer
		add_column :users, :pic_image_height, :integer
  end
end
