# 公告表
class Post < ActiveRecord::Base
  # 关联关系表， 编辑人
  belongs_to :editor, -> { where active: true }, class_name: "Manage::Editor"

  # 查询所有有效数据
	scope :active, -> { where active: true }
   # 创建类方法 返回可编辑字段名称
	cattr_accessor :manage_fields
	self.manage_fields = %w[title content ]

end