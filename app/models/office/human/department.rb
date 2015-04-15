class Office::Human::Department < ActiveRecord::Base
	belongs_to :parent, class_name: self
	belongs_to :administrator, class_name: Office::Human::Employee
	belongs_to :company
	belongs_to :creator, class_name: Manage::Editor
	belongs_to :updater, class_name: Manage::Editor
	has_many :children, -> { where active: true }, class_name: self, foreign_key: 'parent_id' 
	has_many :employees, class_name: Office::Human::Employee
	
	scope :active, -> { where active: true }
	
	validates :administrator_id, existence: true, allow_blank: true
	validates :parent_id, existence: true, allow_blank: true
	validates :company_id, existence: true, allow_blank: true
	validates :creator_id, existence: true, allow_blank: true
	validates :updater_id, existence: true, allow_blank: true
	
	MANAGE_FIELDS = %w[name english_name description administrator_id parent_id company_id]

	cattr_accessor :manage_fields do MANAGE_FIELDS; end
	
	def deletable?
		children.empty? && employees.empty?
	end
end
