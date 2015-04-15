class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_one :account, :foreign_key => 'id', :class_name => "Manage::Account"
	attr_accessor :password_confirmation, :remember_me
	scope :active,  -> { where active: true }

  validates :email, uniqueness: true
	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :email
	validates_uniqueness_of :email
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }

	has_attached_file_with_patch :pic, url: '/image/user/:id_partition/pic/:updated_at.:extension:style_extension', styles: { small: '32x32#' }
	validates_attachment_with_patch :pic, content_type: { content_type: %w[image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif] }

	cattr_accessor :manage_fields
	self.manage_fields = %w[name gender brithday pic tag_list password password_confirmation]
	
end
