class Post < ActiveRecord::Base
	belongs_to :editor, -> { where active: true }
	
	scope :active, -> { where active: true }
	cattr_accessor :manage_fields
	self.manage_fields = %w[title content ]
end



