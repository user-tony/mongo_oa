class AddColumnUpdaterIdWithAttachmentToOfficeHumanDaily < ActiveRecord::Migration
  def change
		add_column :office_human_dailies, :path, :string
		add_column :office_human_dailies, :path_file_name, :string
		add_column :office_human_dailies, :path_file_size, :integer
		add_column :office_human_dailies, :path_content_type, :string
		add_column :office_human_dailies, :path_updated_at, :datetime
		add_column :office_human_dailies, :path_image_width, :integer
		add_column :office_human_dailies, :path_image_height, :integer
  end
end
