class Manage::Grant < ActiveRecord::Base
	belongs_to :editor, -> { where active: true }
	belongs_to :role, -> { where active: true }
	
	scope :active, -> { where active: true }
	
	# validates_existence_of :editor_id, allow_blank: true
	# validates_existence_of :role_id, allow_blank: true
	validates_uniqueness_of :editor_id, :scope => [:active, :role_id], :if => Proc.new { |record| record.active? }, allow_blank: true
	validates_uniqueness_of :role_id, :scope => [:active, :editor_id], :if => Proc.new { |record| record.active? }, allow_blank: true

	# accepts_nested_attributes_for :grants, :reject_if => Proc.new { |attributes| !attributes['id'] && attributes['active'] == '0' }
	
	cattr_accessor :manage_fields
	self.manage_fields = %w[editor_id role_id]
end
