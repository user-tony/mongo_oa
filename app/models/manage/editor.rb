class Manage::Editor < ActiveRecord::Base

	belongs_to :account, :foreign_key => :id, :class_name => "Manage::Account"
	belongs_to :role, -> { where active: true }
	has_many :grants, -> { where active: true }
	has_many :roles, :through => :grants
	# belongs_to :supervisor, :class_name => "Editor"
	# has_many :subordinates, :foreign_key => :supervisor_id, :class_name => "Editor"
	
	accepts_nested_attributes_for :grants, reject_if: -> (attr){ !attr['id'] && attr['active'] == '0' }
	
	DEPARTMENTS = %w[产品技术部 市场部 财务部 人力资源部 客服部 行政部 ]
	
	# validates_existence_of :user
	validates_uniqueness_of :name, :scope => :active, :if => Proc.new { |record| record.active? }, :allow_blank => true
	validates_uniqueness_of :identifier, :scope => :active, :if => Proc.new { |record| record.active? }, :allow_blank => true
	# validates_inclusion_of :department, :in => DEPARTMENTS, :allow_blank => true
	validates_associated :grants
	
	scope :active, -> { where active: true }
	
	def deletable? #:nodoc: all
		self.subordinates.empty?
	end
	
	cattr_accessor :manage_fields do %w[ id name identifier department supervisor_id user_id role_id grants_attributes ] << { grants_attributes: %w{ active role_id id editor_id}} ; end
end
