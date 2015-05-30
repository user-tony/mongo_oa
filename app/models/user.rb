# 用户表

class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  # 关联账号关系
  has_one :account, :foreign_key => 'id', :class_name => "Manage::Account"
  # 建立虚拟字段
	attr_accessor :password_confirmation, :remember_me
  
  # 查询所有有效数据
	scope :active,  -> { where active: true }

  # 验证字段属性  -------------------------------------
  # 验证 邮箱
  validates :email, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }
  # 确认密码字段 
	validates_confirmation_of :password
  # 密码字段在创建时不能为空
	validates_presence_of :password, :on => :create
  # 邮箱不能为空
	validates_presence_of :email
  # 邮箱不能重复
	validates_uniqueness_of :email
	
  
  # 验证字段属性  -------------------------------------
  # 图片字段， 限制图片格式
	has_attached_file_with_patch :pic, url: '/image/user/:id_partition/pic/:updated_at.:extension:style_extension', styles: { small: '32x32#' }
	validates_attachment_with_patch :pic, content_type: { content_type: %w[image/jpeg image/jpg image/pjpeg image/png image/x-png image/gif] }

  # 创建类方法 返回可编辑字段名称
	cattr_accessor :manage_fields
	self.manage_fields = %w[name gender brithday pic tag_list password password_confirmation]
	
end
