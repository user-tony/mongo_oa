class Office::Human::Company < ActiveRecord::Base
	belongs_to :parent, class_name: self
	belongs_to :creator, class_name: Manage::Account
	belongs_to :updater, class_name: Manage::Account
	has_many :children, -> { where active: true }, class_name: self, foreign_key: 'parent_id'
	has_many :departments, -> { where active: true }
	has_many :employees, -> { where active: true }
	
	validates :name, uniqueness: true, allow_blank: true
	# validates :parent, existence: true, allow_blank: true
	# validates :creator, existence: true, allow_blank: true
	# validates :updater, existence: true, allow_blank: true
	
	scope :active, -> { where active: true }
	
	cattr_accessor :manage_fields do %w[name description parent_id]; end
	
	def deletable?
		false
	end

end
