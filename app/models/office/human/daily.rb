class Office::Human::Daily < ActiveRecord::Base
	
	belongs_to :department
	belongs_to :creator, class_name: Manage::Account
	belongs_to :updater, class_name: Manage::Account
	
	validates :department, existence: true, allow_blank: true
	validates :creator, existence: true, allow_blank: true
	validates :updater, existence: true, allow_blank: true
	
	validates :summary, :task, presence: true
	
	cattr_accessor :manage_fields do %w[id title task creator_id name issue summary department_id path ]; end
	
	has_attached_file_with_patch :path, url: '/file/office/human/daily/:id_partition/path/:updated_at.:extension:style_extension'
	do_not_validate_attachment_file_type :path
	
	scope :active, -> { where active: true }
	
	
end
